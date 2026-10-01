import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';

enum CreateOrderStep { order, review, confirm }

sealed class CreateOrderState {
  final int quantity;
  final CreateOrderStep step;

  const CreateOrderState({required this.quantity, required this.step});
}

class CreateOrderInitial extends CreateOrderState {
  const CreateOrderInitial() : super(quantity: 1, step: CreateOrderStep.order);
}

class CreateOrderUpdated extends CreateOrderState {
  const CreateOrderUpdated({required super.quantity, required super.step});
}

class CreateOrderLoading extends CreateOrderState {
  const CreateOrderLoading({required super.quantity, required super.step});
}

class CreateOrderSuccess extends CreateOrderState {
  final OrderModel order;

  const CreateOrderSuccess({
    required this.order,
    required super.quantity,
    required super.step,
  });
}

class CreateOrderFailure extends CreateOrderState {
  final String failure;

  const CreateOrderFailure({
    required this.failure,
    required super.quantity,
    required super.step,
  });
}
