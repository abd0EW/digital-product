import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/payments/data/models/customer_payment_model.dart';
import 'package:flutter/material.dart';
import 'customer_payment_card.dart';

class CustomerPaymentsSliver extends StatelessWidget {
  const CustomerPaymentsSliver({required this.customers, super.key});

  final List<CustomerPaymentModel> customers;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppSpacing.md),
      sliver: SliverList.builder(
        itemCount: customers.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppText.body(
                'إجمالي ما دفعه كل عميل',
                textAlign: TextAlign.right,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: CustomerPaymentCard(customer: customers[index - 1]),
          );
        },
      ),
    );
  }
}
