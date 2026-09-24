import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';

import '../failures/failure.dart';

abstract class ServicesRepository {
  Future<Either<Failure, List<ServiceModel>>> getServices();
}
