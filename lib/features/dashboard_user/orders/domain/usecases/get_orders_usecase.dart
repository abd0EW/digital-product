// // get_orders_use_case.dart

// import 'package:dartz/dartz.dart';
// import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
// import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
// import 'package:digital_product/features/dashboard_user/orders/domain/repositories/orders_repository.dart';

// class GetOrdersUseCase {
//   final OrdersRepository _ordersRepository;

//   GetOrdersUseCase(this._ordersRepository);

//   Future<Either<OrderFailure, List<OrderModel>>> call() {
//     return _ordersRepository.getUserOrders();
//   }
// }
