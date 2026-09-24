class OwnerServiceModel {
  final String name;
  final String price;
  final String unit;
  final String paymentInfo;
  final bool isEnabled;
  final String category;

  const OwnerServiceModel({
    required this.name,
    required this.price,
    required this.unit,
    required this.paymentInfo,
    required this.isEnabled,
    required this.category,
  });
}
