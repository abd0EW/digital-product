import 'package:digital_product/core/utils/order_display_formatter.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_order_assignment_cell.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_order_worker_cell.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_status_badge.dart';
import 'package:flutter/material.dart';

DataRow buildRow(OrderModel order) {
    final orderReference =
        order.orderNumber?.toString() ?? order.id ?? 'غير متاح';
    final amount = OrderDisplayFormatter.price(order.totalAmount);
    final currency = order.service?.currency;

    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 100,
            child: Text(orderReference, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 125,
            child: Text(
              order.service?.nameAr ?? 'غير متاحة',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(Text(currency == null ? amount : '$amount $currency')),
        DataCell(OrderStatusBadge(status: order.status)),
        DataCell(OwnerOrderWorkerCell(order: order)),
        DataCell(OwnerOrderAssignmentCell(order: order)),
      ],
    );
  }
