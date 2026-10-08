import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_order_confirm_bottom_header.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_order_confirm_payment_selector.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class BuildBeforePaymentOrder extends StatelessWidget {
  const BuildBeforePaymentOrder({super.key, required this.serviceModel});
  final ServiceModel serviceModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('before-payment'),
      spacing: 30,
      mainAxisSize: MainAxisSize.min,
      children: [
        BuildOrderConfirmBottomHeader(serviceModel: serviceModel),

        const BuildOrderConfirmPaymentSelector(),

        AppButton(
          width: double.infinity,
          title: 'ادفع ${serviceModel.price} ${serviceModel.currency}',
          onPressed: () {
            // تنفيذ عملية الدفع
          },
          backgroundColor: AppColors.secondaryButtonBackground,
          foregroundColor: AppColors.primaryButtonText,
        ),
      ],
    );
  }
}
