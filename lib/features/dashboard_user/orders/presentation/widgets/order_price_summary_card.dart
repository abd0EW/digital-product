import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_summary_card.dart';
import 'package:flutter/material.dart';

class OrderPriceSummaryCard extends StatelessWidget {
  const OrderPriceSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.title('المبلغ الإجمالي'),
          SizedBox(height: AppSpacing.sm),
          _PriceRow(label: 'سعر الخدمة', value: '70 ر.س'),
          _PriceRow(label: 'ضريبة القيمة المضافة (15%)', value: '10.5 ر.س'),
          Divider(height: AppSpacing.lg, color: AppColors.cardBorder),
          _PriceRow(
            label: 'الإجمالي النهائي',
            value: '80.5 ر.س',
            emphasized: true,
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.body(
            label,
            color: emphasized ? AppColors.headingText : AppColors.bodyText,
          ),
          AppText.title(
            value,
            color: emphasized
                ? AppColors.secondaryButtonBackground
                : AppColors.headingText,
          ),
        ],
      ),
    );
  }
}
