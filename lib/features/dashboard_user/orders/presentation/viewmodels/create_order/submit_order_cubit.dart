import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_error_message_handler.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/submit_order_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/submit_order_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitOrderCubit extends Cubit<SubmitOrderState> {
  final SubmitOrderUseCase _submitOrderUseCase;

  SubmitOrderCubit({required this._submitOrderUseCase})
    : super(const SubmitOrderInitial());

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;
  // create order
  Future<void> createOrder({
    required OrderModel order,
    required PlatformFile? file,
  }) async {
    debugPrint('CreateOrderCubit: createOrder called with order: $order');

    if (file == null) return;

    _isSubmitting = true;
    emit(const SubmitOrderLoading());

    try {
      final result = await _submitOrderUseCase(order: order, file: file);
      print("=====================");
      print(file);
      if (isClosed) return;

      result.fold(
        (failure) => _emitFailure(failure),
        (createdOrder) => _emitSuccess(createdOrder),
      );
    } finally {
      _isSubmitting = false;
    }
  }

  void _emitSuccess(OrderModel order) {
    emit(SubmitOrderSuccess(order: order));
  }

  void _emitFailure(OrderFailure failure) {
    emit(
      SubmitOrderFailure(
        failure: OrderErrorMessageHandler.getMessage(exception: failure),
      ),
    );
  }
}
