import 'dart:async';
import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_before_payment_order.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_order_confirm_bottom_header.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_order_confirm_payment_selector.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class BuildOrderConfirmBottomSheet extends StatefulWidget {
  const BuildOrderConfirmBottomSheet({super.key, required this.serviceModel});

  final ServiceModel serviceModel;

  @override
  State<BuildOrderConfirmBottomSheet> createState() =>
      _BuildOrderConfirmBottomSheetState();
}

class _BuildOrderConfirmBottomSheetState
    extends State<BuildOrderConfirmBottomSheet> {
  Timer? _closeTimer;

  bool get isPaymentAfter =>
      widget.serviceModel.paymentTiming == 'الدفع بعد الإنجاز';

  @override
  void initState() {
    super.initState();

    if (!isPaymentAfter) {
      _closeTimer = Timer(const Duration(seconds: 3), () {
        if (!mounted) return;

        Navigator.of(context).pop();
      });
    }
  }

  @override
  void dispose() {
    _closeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isPaymentAfter
        ? AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            child: _buildAfterPayment(context),
          )
        : BuildBeforePaymentOrder(serviceModel: widget.serviceModel);
  }

  Widget _buildAfterPayment(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: const ValueKey('after-payment'),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
      tween: Tween(begin: 0.8, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Column(
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
              _closeTimer?.cancel();
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
      ),
    );
  }
}
