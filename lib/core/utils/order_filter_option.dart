class OrderFilterOption {
  final String label;
  final String? status;

  const OrderFilterOption({required this.label, required this.status});
}

const List<OrderFilterOption> orderFilterOptions = [
  OrderFilterOption(label: 'الكل', status: null),
  OrderFilterOption(label: 'بانتظار الدفع', status: 'pending'),
  OrderFilterOption(label: 'قيد التنفيذ', status: 'in_progress'),
  OrderFilterOption(label: 'مكتمل', status: 'completed'),
  OrderFilterOption(label: 'مرفوض', status: 'rejected'),
];
