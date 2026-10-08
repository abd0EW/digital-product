import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/get_order_repository/get_order_repository.dart';

class GetOrdersUsecase {
  final GetOrderRepository _getordersRepository;

  GetOrdersUsecase(this._getordersRepository);

  Future<Either<OrderFailure, List<OrderModel>>> call() {
    return _getordersRepository.getUserOrders();
  }

  Future<Either<OrderFailure, List<OrderFileModel>>> getOrderFilesUseCase({
    required String orderId,
  }) {
    return _getordersRepository.getOrderFiles(orderId: orderId);
  }
}
