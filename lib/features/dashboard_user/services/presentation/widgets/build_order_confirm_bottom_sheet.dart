import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';

import 'package:digital_product/features/dashboard_user/services/presentation/widgets/build_order_confirm_bottom_header.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/build_order_confirm_payment_selector.dart';
import 'package:flutter/material.dart';

class BuildOrderConfirmBottomSheet extends StatelessWidget {
  const BuildOrderConfirmBottomSheet({super.key, required this.serviceModel});
  final ServiceModel serviceModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      mainAxisSize: MainAxisSize.min,
      children: [
        BuildOrderConfirmBottomHeader(serviceModel: serviceModel),
        BuildOrderConfirmPaymentSelector(),
        AppButton(
          width: double.infinity,
          title: "ادفع ${serviceModel.price} ر.س   ",
          onPressed: () {},
          backgroundColor: AppColors.secondaryButtonBackground,
          foregroundColor: AppColors.primaryButtonText,
        ),
      ],
    );
  }
}
