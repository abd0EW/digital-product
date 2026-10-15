// save_order_file_use_case.dart

import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/create_order_repository/create_orders_repository.dart';

class SaveOrderFileUseCase {
  final CreateOrdersRepository _ordersRepository;

  SaveOrderFileUseCase(this._ordersRepository);

  Future<Either<OrderFailure, OrderFileModel>> call({
    required OrderFileModel file,
  }) {
    return _ordersRepository.saveOrderFile(file: file);
  }
}
