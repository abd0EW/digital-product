import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/payments/data/models/payment_transaction_model.dart';
import 'package:flutter/material.dart';

class PaymentTransactionCard extends StatelessWidget {
  const PaymentTransactionCard({required this.payment, super.key});

  final PaymentTransactionModel payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(payment.customerName, maxLines: 1),

                  AppText.body(payment.serviceName, maxLines: 1),

                  AppText.caption(
                    '${payment.orderNumber}  •  ${payment.date}',
                    color: AppColors.bodyText,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            AppText.title(
              '${payment.amount} ر.س',
              color: AppColors.tealPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
