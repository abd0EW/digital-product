import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/dashboard_owner/payments/data/payment_data.dart';
import 'package:digital_product/features/dashboard_owner/payments/presentation/views/owner_payment_customers_view.dart';
import 'package:digital_product/features/dashboard_owner/payments/presentation/widgets/payment_history_sliver.dart';
import 'package:digital_product/features/dashboard_owner/payments/presentation/widgets/payment_summary_sliver.dart';
import 'package:flutter/material.dart';

class OwnerPaymentsView extends StatelessWidget {
  const OwnerPaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            PaymentSummarySliver(
              totalPaid: totalPaid,
              paidCustomersCount: customerPayments.length,
              onShowMore: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const OwnerPaymentCustomersView(),
                  ),
                );
              },
            ),
            PaymentHistorySliver(payments: recentPayments),
          ],
        ),
      ),
    );
  }
}
