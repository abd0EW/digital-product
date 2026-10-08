import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_details_card.dart';
import 'package:flutter/material.dart';

class OrderPriceSummaryCard extends StatelessWidget {
  const OrderPriceSummaryCard({required this.order, super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.title('ملخص الأسعار'),
          const SizedBox(height: AppSpacing.sm),
          _PriceRow(label: "الاجمالي ", value: "${order.totalAmount} ريال"),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AppText.switches(label, color: Colors.black)),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: AppText.title(
              value,
              color: AppColors.headingText,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
