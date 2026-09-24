import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/payments/data/models/customer_payment_model.dart';
import 'package:flutter/material.dart';

class CustomerPaymentCard extends StatelessWidget {
  const CustomerPaymentCard({required this.customer, super.key});

  final CustomerPaymentModel customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: AppColors.successBackground,
              child: AppText.title(
                customer.name.characters.first,
                color: AppColors.tealPrimary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(customer.name, maxLines: 1),
                  const SizedBox(height: 4),
                  AppText.body(customer.email, maxLines: 1),
                  const SizedBox(height: AppSpacing.xs),
                  AppText.body(
                    '${customer.paidOrdersCount} طلبات مدفوعة',
                    color: AppColors.bodyText,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const AppText.body('إجمالي المدفوع'),
                const SizedBox(height: 4),
                AppText.title(
                  '${customer.totalPaid} ر.س',
                  color: AppColors.tealPrimary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
