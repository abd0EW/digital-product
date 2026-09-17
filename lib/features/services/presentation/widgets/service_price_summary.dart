import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ServicePriceSummary extends StatelessWidget {
  const ServicePriceSummary({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText.caption(
                  'المبلغ التقريبي (شامل الضريبة 15%)',
                  color: AppColors.bodyText,
                ),

                const SizedBox(height: 3),

                AppText.title(
                  '${totalPrice.toStringAsFixed(2)} ر.س',
                  color: AppColors.headingText,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.successBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const AppText.caption(
              'دفع بعد الإنجاز',
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}
