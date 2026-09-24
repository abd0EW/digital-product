import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_info.dart';
import 'package:flutter/material.dart';

class AppOrderCardInfo extends StatelessWidget {
  const AppOrderCardInfo({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: OrderInfo(order: order)),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: AppColors.primaryButtonBackground,

            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.cardBackground,
          ),
        ),
      ],
    );
  }
}
