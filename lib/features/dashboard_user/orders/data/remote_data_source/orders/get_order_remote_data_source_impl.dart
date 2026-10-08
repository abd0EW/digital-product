import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders/get_order_remote_data_source.dart';
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
  Future<List<OrderFileModel>> getOrderFiles({required String orderId}) async {
    final response = await _client
        .from('order_files')
        .select()
        .eq('order_id', orderId)
        .order('created_at', ascending: true);
    print("================================");
    print(response);
    return response.map((json) => OrderFileModel.fromJson(json)).toList();
  }
}
