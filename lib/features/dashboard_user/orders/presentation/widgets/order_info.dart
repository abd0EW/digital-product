import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.title(
          order.serviceName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        AppText.caption(
          '${order.orderNumber}  •  ${order.quantity}',
          color: AppColors.bodyText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        AppText.caption(
          '${order.date}  •  ${order.time}',
          color: AppColors.bodyText,
        ),
      ],
    );
  }
}
