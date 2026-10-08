import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';

abstract class GetOrderRemoteDataSource {
  Future<OrderModel> createOrder({required OrderModel order});

  Future<List<OrderModel>> getUserOrders();

  Future<List<OrderFileModel>> getOrderFiles({required String orderId});
}
