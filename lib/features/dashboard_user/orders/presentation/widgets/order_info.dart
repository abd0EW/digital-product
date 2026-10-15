import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return AppText.title(
      order.service?.nameAr ?? "الخدمه ",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
