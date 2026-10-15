import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/get_order_repository/get_order_repository.dart';

class GetFileUrlUsecase {
  GetFileUrlUsecase(this._getOrderRepository);

  final GetOrderRepository _getOrderRepository;

  Future<Either<OrderFailure, String>> getOrderFileUrl({
    required String storagePath,
  }) async {
    return await _getOrderRepository.getOrderFileUrl(
      storagePath: storagePath,
    );
  }
}
