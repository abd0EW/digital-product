import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/payments/data/models/payment_transaction_model.dart';
import 'package:flutter/material.dart';
import 'payment_transaction_card.dart';

class PaymentHistorySliver extends StatelessWidget {
  const PaymentHistorySliver({required this.payments, super.key});

  final List<PaymentTransactionModel> payments;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      sliver: SliverList.builder(
        itemCount: payments.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppText.switches(
                'سجل المدفوعات',
                textAlign: TextAlign.right,
                color: AppColors.headingText,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: PaymentTransactionCard(payment: payments[index - 1]),
          );
        },
      ),
    );
  }
}
