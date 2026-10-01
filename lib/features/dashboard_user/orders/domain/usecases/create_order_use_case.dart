// create_order_use_case.dart

import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/orders_repository.dart';

class CreateOrderUseCase {
  final OrdersRepository _ordersRepository;

  CreateOrderUseCase(this._ordersRepository);

  Future<Either<OrderFailure, OrderModel>> call({required OrderModel order}) {
    return _ordersRepository.createOrder(order: order);
  }
}
