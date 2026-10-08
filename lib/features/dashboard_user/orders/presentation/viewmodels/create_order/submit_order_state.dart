import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';

sealed class SubmitOrderState {
  const SubmitOrderState();
}

class SubmitOrderInitial extends SubmitOrderState {
  const SubmitOrderInitial();
}

class SubmitOrderLoading extends SubmitOrderState {
  const SubmitOrderLoading();
}

class SubmitOrderSuccess extends SubmitOrderState {
  final OrderModel order;

  const SubmitOrderSuccess({required this.order});
}

class SubmitOrderFailure extends SubmitOrderState {
  final String failure;

  const SubmitOrderFailure({required this.failure});
}
