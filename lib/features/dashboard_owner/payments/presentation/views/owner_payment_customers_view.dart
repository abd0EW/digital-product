import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/dashboard_owner/payments/data/payment_data.dart';
import 'package:digital_product/features/dashboard_owner/payments/presentation/widgets/customer_payments_sliver.dart';
import 'package:flutter/material.dart';

class OwnerPaymentCustomersView extends StatelessWidget {
  const OwnerPaymentCustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        centerTitle: false,
        title: const Text('العملاء الذين دفعوا'),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            CustomerPaymentsSliver(customers: customerPayments),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}
