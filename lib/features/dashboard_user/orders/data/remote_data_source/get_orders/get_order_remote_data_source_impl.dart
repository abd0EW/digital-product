import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/get_orders/get_order_remote_data_source.dart';
import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetOrderRemoteDataSourceImpl implements GetOrderRemoteDataSource {
  final SupabaseClient _client;

  GetOrderRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  @override
  Future<OrderModel> createOrder({required OrderModel order}) async {
    try {
      final user = _client.auth.currentUser;

      if (user == null) {
        throw Exception('User is not authenticated');
      }

      final response = await _client
          .from('orders')
          .insert(order.toCreateJson())
          .select()
          .single();

      return OrderModel.fromJson(Map<String, dynamic>.from(response));
    } catch (e) {
      print('OrdersRemoteDataSourceImpl: Failed to create order: $e');

      rethrow;
    }
  }

  @override
  Future<List<OrderModel>> getUserOrders() async {
    try {
      final user = _client.auth.currentUser;

      if (user == null) {
        throw Exception('User is not authenticated');
      }

      final response = await _client
          .from('orders')
          .select('''
* ,service:services(*)
 ''')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return response
          .map<OrderModel>(
            (order) => OrderModel.fromJson(Map<String, dynamic>.from(order)),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderModel?> getUserOrderById({required String orderId}) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final response = await _client
        .from('orders')
        .select('*, service:services(*)')
        .eq('id', orderId)
        .eq('user_id', user.id)
        .maybeSingle();

    if (response == null) return null;

    return OrderModel.fromJson(Map<String, dynamic>.from(response));
  }

  @override
  Future<List<OrderFileModel>> getOrderFiles({required String orderId}) async {
    final response = await _client
        .from('order_files')
        .select()
        .eq('order_id', orderId)
        .order('created_at', ascending: true);

    return response.map((json) => OrderFileModel.fromJson(json)).toList();
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final response = await _client
        .from('orders')
        .select('*, service:services(*)')
        .order('created_at', ascending: false);

    final orderRows = response
        .map((order) => Map<String, dynamic>.from(order))
        .toList(growable: false);
    final workerIds = orderRows
        .map((order) => order['worker_id'] as String?)
        .whereType<String>()
        .where((workerId) => workerId.trim().isNotEmpty)
        .toSet()
        .toList(growable: false);
    final workerNamesById = <String, String>{};

    if (workerIds.isNotEmpty) {
      final workers = await _client
          .from('profiles')
          .select('id, full_name')
          .inFilter('id', workerIds);

      for (final worker in workers) {
        final row = Map<String, dynamic>.from(worker);
        final id = row['id'] as String?;
        final fullName = row['full_name'] as String?;
        if (id != null && fullName != null && fullName.trim().isNotEmpty) {
          workerNamesById[id] = fullName;
        }
      }
    }

    return orderRows
        .map<OrderModel>((order) {
          order['worker_name'] = workerNamesById[order['worker_id']];
          return OrderModel.fromJson(order);
        })
        .toList(growable: false);
  }

  @override
  Future<void> assignWorker({
    required String orderId,
    required String workerId,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('User is not authenticated');
    }

    final ownerProfile = await _client
        .from('profiles')
        .select('id, role')
        .eq('id', user.id)
        .maybeSingle();

    if (ownerProfile == null ||
        ownerProfile['role'] != UserRole.owner.value) {
      throw const AuthException('Current user is not an owner');
    }

    final invitation = await _client
        .from('worker_invitations')
        .select('id')
        .eq('invited_by', ownerProfile['id'])
        .eq('accepted_user_id', workerId)
        .eq('status', 'accepted')
        .maybeSingle();

    if (invitation == null) {
      throw Exception('Worker is not an accepted worker for this owner');
    }

    final assignedAt = DateTime.now().toUtc().toIso8601String();
    final updatedOrder = await _client
        .from('orders')
        .update({
          'worker_id': workerId,
          'assigned_at': assignedAt,
          'started_at': assignedAt,
        })
        .eq('id', orderId)
        .eq('status', 'in_progress')
        .isFilter('worker_id', null)
        .select('id')
        .maybeSingle();

    if (updatedOrder == null) {
      throw Exception(
        'Order is unavailable or current owner is not allowed to assign it',
      );
    }
  }
}
