import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<OrderModel> createOrder({required OrderModel order});

  Future<List<OrderModel>> getUserOrders();
}
