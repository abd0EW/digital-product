import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders/order_remote_data_source.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final SupabaseClient _client;

  OrdersRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  @override
  Future<OrderModel> createOrder({required OrderModel order}) async {
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
  }

  @override
  Future<List<OrderModel>> getUserOrders() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated');
    }

    final response = await _client
        .from('orders')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return response
        .map<OrderModel>(
          (json) => OrderModel.fromJson(Map<String, dynamic>.from(json)),
        )
        .toList();
  }
}
