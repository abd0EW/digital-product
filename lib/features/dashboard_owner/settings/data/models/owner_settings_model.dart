class OwnerSettingsModel {
  final String platformName;
  final double vatPercentage;
  final bool notifyOnNewOrder;
  final bool notifyOnPayment;

  const OwnerSettingsModel({
    required this.platformName,
    required this.vatPercentage,
    required this.notifyOnNewOrder,
    required this.notifyOnPayment,
  });
}
