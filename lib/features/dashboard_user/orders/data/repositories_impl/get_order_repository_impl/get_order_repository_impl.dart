import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders/get_order_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/get_order_repository/get_order_repository.dart';

class GetOrderRepositoryImpl implements GetOrderRepository {
  const GetOrderRepositoryImpl({required this._remoteDataSource});
  final GetOrderRemoteDataSource _remoteDataSource;
  @override
  Future<Either<OrderFailure, List<OrderModel>>> getUserOrders() async {
    try {
      final response = await _remoteDataSource.getUserOrders();
      return Right(response);
    } catch (exception) {
      return Left(
        CreateOrderFail(exception: exception, message: exception.toString()),
      );
    }
  }

  @override
  Future<Either<OrderFailure, List<OrderFileModel>>> getOrderFiles({
    required String orderId,
  }) async {
    try {
      final files = await _remoteDataSource.getOrderFiles(orderId: orderId);

      return Right(files);
    } catch (exception) {
      return Left(
        CreateOrderFail(exception: exception, message: exception.toString()),
      );
    }
  }
}
