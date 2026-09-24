class OwnerOrderModel {
  const OwnerOrderModel({
    required this.customerName,
    required this.serviceName,
    required this.amount,
    required this.status,
    this.orderNumber,
    this.assignedWorkerId,
    this.assignedWorkerName,
  });

  final String customerName;
  final String serviceName;
  final String amount;
  final String status;
  final String? orderNumber;
  final String? assignedWorkerId;
  final String? assignedWorkerName;

  OwnerOrderModel copyWith({
    String? status,
    String? assignedWorkerId,
    String? assignedWorkerName,
  }) {
    return OwnerOrderModel(
      customerName: customerName,
      serviceName: serviceName,
      amount: amount,
      status: status ?? this.status,
      orderNumber: orderNumber,
      assignedWorkerId: assignedWorkerId ?? this.assignedWorkerId,
      assignedWorkerName: assignedWorkerName ?? this.assignedWorkerName,
    );
  }
}
