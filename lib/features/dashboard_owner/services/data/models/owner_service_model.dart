import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';

class OwnerServiceModel {
  final List<ServiceModel> servicesModel;

  const OwnerServiceModel({required this.servicesModel});

  factory OwnerServiceModel.fromJson(Map<String, dynamic> json) {
    return OwnerServiceModel(
      servicesModel: (json['services'])
          .map((element) => ServiceModel.fromJson(element))
          .toList(),
    );
  }
}
