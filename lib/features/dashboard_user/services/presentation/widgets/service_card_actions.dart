import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceCardActions extends StatelessWidget {
  final ServiceModel serviceModel;

  final VoidCallback? onPressed;

  const ServiceCardActions({
    super.key,
    required this.serviceModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                AppText.title(
                  "${serviceModel.price}",
                  color: AppColors.tealPrimary,
                ),

                const SizedBox(width: 3),

                AppText.caption(
                  serviceModel.currency,
                  color: AppColors.tealPrimary,
                ),
              ],
            ),

            const SizedBox(height: 2),

            AppText.caption(serviceModel.pricingUnit),
          ],
        ),

        AppButton(
          title: "طلب الخدمه ",
          height: 40,
          onPressed: onPressed,
          backgroundColor: AppColors.navyPrimary,
          foregroundColor: AppColors.appBackground,
        ),
      ],
    );
  }
}
