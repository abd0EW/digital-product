class PaymentTransactionModel {
  const PaymentTransactionModel({
    required this.customerName,
    required this.serviceName,
    required this.orderNumber,
    required this.amount,
    required this.date,
    this.isPending = false,
  });

  final String customerName;
  final String serviceName;
  final String orderNumber;
  final int amount;
  final String date;
  final bool isPending;
}
