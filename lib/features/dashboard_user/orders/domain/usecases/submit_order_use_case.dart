import 'package:dartz/dartz.dart';
import 'package:digital_product/core/utils/mime_type/mime_type_resolver.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/create_order_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/save_order_file_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/upload_order_file_use_case.dart';
import 'package:file_picker/file_picker.dart';

class SubmitOrderUseCase {
  final CreateOrderUseCase _createOrderUseCase;
  final UploadOrderFileUseCase _uploadOrderFileUseCase;
  final SaveOrderFileUseCase _saveOrderFileUseCase;
  final MimeTypeResolver _mimeTypeResolver;

  SubmitOrderUseCase({
    required this._createOrderUseCase,
    required this._uploadOrderFileUseCase,
    required this._saveOrderFileUseCase,
    required this._mimeTypeResolver,
  });

  Future<Either<OrderFailure, OrderModel>> call({
    required OrderModel order,
    required PlatformFile file,
  }) async {
    final createResult = await _createOrderUseCase(order: order);

    return createResult.fold(
      (failure) {
        return Left(failure);
      },
      (createdOrder) async {
        final orderId = createdOrder.id;
        final userId = createdOrder.userId;

        if (orderId == null || userId == null) {
          return Left(
            CreateOrderFail(
              message: 'Order id or user id is missing',
              exception: Exception('Order id or user id is missing'),
            ),
          );
        }

        final uploadResult = await _uploadOrderFileUseCase(
          file: file,
          userId: userId,
          orderId: orderId,
        );

        return uploadResult.fold(
          (failure) {
            return Left(failure);
          },
          (storagePath) async {
            final orderFile = OrderFileModel(
              orderId: orderId,
              uploadedBy: userId,
              fileType: 'input',
              fileName: file.name,
              storagePath: storagePath,
              mimeType: _mimeTypeResolver.getMimeType(file.extension),
              bucketName: 'user-files',
            );

            final saveResult = await _saveOrderFileUseCase(file: orderFile);

            return saveResult.fold(
              (failure) {
                return Left(failure);
              },
              (_) {
                return Right(createdOrder);
              },
            );
          },
        );
      },
    );
  }
}
