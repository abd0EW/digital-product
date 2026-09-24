import 'package:digital_product/features/dashboard_owner/orders/data/models/owner_order_model.dart';
import 'package:flutter/material.dart';

class OwnerOrderTableRow extends StatelessWidget {
  final OwnerOrderModel order;

  const OwnerOrderTableRow({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(flex: 2, child: Text(order.customerName)),
        Expanded(flex: 2, child: Text(order.serviceName)),
        Expanded(
          child: Text('${order.amount} ر.س', textAlign: TextAlign.center),
        ),
        Expanded(child: Text(order.status, textAlign: TextAlign.center)),
      ],
    );
  }
}
