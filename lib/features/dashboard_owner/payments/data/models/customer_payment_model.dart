class CustomerPaymentModel {
  const CustomerPaymentModel({
    required this.name,
    required this.email,
    required this.totalPaid,
    required this.paidOrdersCount,
  });

  final String name;
  final String email;
  final int totalPaid;
  final int paidOrdersCount;
}
