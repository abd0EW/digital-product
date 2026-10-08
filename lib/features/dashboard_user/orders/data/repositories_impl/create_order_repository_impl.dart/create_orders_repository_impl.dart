import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders/get_order_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders_files/order_files_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:file_picker/file_picker.dart';
import '../../../domain/repositories/create_order_repository/create_orders_repository.dart';
import '../../models/order_model.dart';

class CreateOrdersRepositoryImpl implements CreateOrdersRepository {
  final GetOrderRemoteDataSource _remoteDataSource;
  final OrderFilesRemoteDataSourceImpl _orderFilesRemoteDataSourceImpl;
  CreateOrdersRepositoryImpl({
    required this._remoteDataSource,
    required this._orderFilesRemoteDataSourceImpl,
  });

  @override
  Future<Either<OrderFailure, OrderModel>> createOrder({
    required OrderModel order,
  }) async {
    try {
      final response = await _remoteDataSource.createOrder(order: order);

      return Right(response);
    } on Exception catch (exception) {
      return Left(
        CreateOrderFail(exception: exception, message: exception.toString()),
      );
    }
  }

  @override
  Future<Either<OrderFailure, String>> uploadOrderFile({
    required PlatformFile file,
    required String userId,
    required String orderId,
  }) async {
    try {
      final storagePath = await _orderFilesRemoteDataSourceImpl.uploadOrderFile(
        file: file,
        userId: userId,
        orderId: orderId,
      );

      return Right(storagePath);
    } catch (exception) {
      return Left(
        CreateOrderFail(exception: exception, message: exception.toString()),
      );
    }
  }

  @override
  Future<Either<OrderFailure, OrderFileModel>> saveOrderFile({
    required OrderFileModel file,
  }) async {
    try {
      final response = await _orderFilesRemoteDataSourceImpl.saveOrderFile(
        file: file,
      );

      return Right(response);
    } catch (exception) {
      return Left(
        CreateOrderFail(exception: exception, message: exception.toString()),
      );
    }
  }
}
