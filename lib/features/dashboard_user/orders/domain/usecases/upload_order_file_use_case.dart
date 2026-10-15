// upload_order_file_use_case.dart

import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/create_order_repository/create_orders_repository.dart';
import 'package:file_picker/file_picker.dart';

class UploadOrderFileUseCase {
  final CreateOrdersRepository _ordersRepository;

  UploadOrderFileUseCase(this._ordersRepository);

  Future<Either<OrderFailure, String>> call({
    required PlatformFile file,
    required String userId,
    required String orderId,
  }) {
    return _ordersRepository.uploadOrderFile(
      file: file,
      userId: userId,
      orderId: orderId,
    );
  }
}
