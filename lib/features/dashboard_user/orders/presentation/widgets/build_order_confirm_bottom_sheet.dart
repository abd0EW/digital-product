import 'dart:async';
import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_before_payment_order.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class BuildOrderConfirmBottomSheet extends StatelessWidget {
  const BuildOrderConfirmBottomSheet({super.key, required this.serviceModel});

  final ServiceModel serviceModel;

  bool get isPaymentAfter => serviceModel.paymentTiming == 'الدفع بعد الإنجاز';

  @override
  Widget build(BuildContext context) {
    return isPaymentAfter
        ? _buildAfterPayment(context)
        : BuildBeforePaymentOrder(serviceModel: serviceModel);
  }

  Widget _buildAfterPayment(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: AppColors.successBackground,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 40,
            color: AppColors.success,
          ),
        ),

        const SizedBox(height: 20),

        const AppText.title(
          'تم استلام طلبك',
          color: AppColors.headingText,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),

        const AppText.caption(
          'سيبدأ تنفيذ طلبك، وسيتم طلب الدفع بعد اكتمال الخدمة.',
          color: AppColors.bodyText,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),

        AppButton(
          width: double.infinity,
          title: 'حسنًا',
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: AppColors.secondaryButtonBackground,
          foregroundColor: AppColors.primaryButtonText,
        ),

        const SizedBox(height: 8),

        const AppText.caption(
          'سيتم إغلاق النافذة تلقائيًا',
          color: AppColors.bodyText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
