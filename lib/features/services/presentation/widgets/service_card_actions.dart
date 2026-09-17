import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ServiceCardActions extends StatelessWidget {
  final String price;
  final String currency;
  final String priceDescription;
  final String buttonTitle;
  final VoidCallback onPressed;

  const ServiceCardActions({
    super.key,
    required this.price,
    required this.currency,
    required this.priceDescription,
    required this.buttonTitle,
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
                AppText.title(price, color: AppColors.tealPrimary),

                const SizedBox(width: 3),

                AppText.caption(currency, color: AppColors.tealPrimary),
              ],
            ),

            const SizedBox(height: 2),

            AppText.caption(priceDescription),
          ],
        ),

        AppButton(
          title: buttonTitle,
          height: 40,
          onPressed: onPressed,
          backgroundColor: AppColors.navyPrimary,
          foregroundColor: AppColors.appBackground,
        ),
      ],
    );
  }
}
