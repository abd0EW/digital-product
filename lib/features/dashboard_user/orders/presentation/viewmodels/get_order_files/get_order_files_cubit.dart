import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_error_message_handler.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_file_url_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_orders_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOrderFilesCubit extends Cubit<GetOrderFilesState> {
  final GetOrdersUsecase _getOrdersUsecase;
  final GetFileUrlUsecase _getFileUrlUsecase;

  GetOrderFilesCubit({
    required this._getOrdersUsecase,
    required this._getFileUrlUsecase,
  }) : super(const GetOrderFilesInitial());

  Future<void> getOrderFiles({required String orderId}) async {
    if (isClosed) return;

    emit(const GetOrderFilesLoading());

    try {
      final result = await _getOrdersUsecase.getOrderFilesUseCase(
        orderId: orderId,
      );

      if (isClosed) return;

      result.fold(
        (failure) {
          debugPrint('Failed to load order files: $failure');
          emit(
            GetOrderFilesFailure(
              OrderErrorMessageHandler.getMessage(exception: failure),
            ),
          );
        },
        (files) {
          if (files.isEmpty) {
            emit(const GetOrderFilesEmpty());
          } else {
            emit(GetOrderFilesSuccess(List.unmodifiable(files)));
          }
        },
      );
    } catch (_) {
      if (!isClosed) {
        emit(
          const GetOrderFilesFailure('تعذر تحميل ملفات الطلب. حاول مرة أخرى.'),
        );
      }
    }
  }

  Future<String?> getFileUrl({required String storagePath}) async {
    final result = await _getFileUrlUsecase.getOrderFileUrl(
      storagePath: storagePath,
    );

    return result.fold((failure) {
      debugPrint(
        'Unable to create order attachment signed URL: ${failure.message}',
      );
      return null;
    }, (signedUrl) => signedUrl);
  }
}
