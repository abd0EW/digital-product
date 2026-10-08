import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';

abstract class GetOrderRepository {
  Future<Either<OrderFailure, List<OrderModel>>> getUserOrders();
  Future<Either<OrderFailure, List<OrderFileModel>>> getOrderFiles({
    required String orderId,
  });
}
