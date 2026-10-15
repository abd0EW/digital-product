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
