import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';

sealed class GetOrderState {
  const GetOrderState();
}

final class GetOrderInitial extends GetOrderState {
  const GetOrderInitial();
}

final class GetOrderLoading extends GetOrderState {
  const GetOrderLoading();
}

final class GetOrderSuccess extends GetOrderState {
  final List<OrderModel> orders;

  const GetOrderSuccess(this.orders);
}

final class GetOrderEmpty extends GetOrderState {
  const GetOrderEmpty();
}

final class GetOrderFailure extends GetOrderState {
  final String message;

  const GetOrderFailure(this.message);
}
