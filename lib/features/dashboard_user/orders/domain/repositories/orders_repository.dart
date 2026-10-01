import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';

import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';

import 'package:file_picker/file_picker.dart';

import '../../data/models/order_model.dart';

abstract class OrdersRepository {
  Future<Either<OrderFailure, OrderModel>> createOrder({
    required OrderModel order,
  });
  Future<Either<OrderFailure, String>> uploadOrderFile({
    required PlatformFile file,
    required String userId,
    required String orderId,
  });

  Future<Either<OrderFailure, OrderFileModel>> saveOrderFile({
    required OrderFileModel file,
  });
}
