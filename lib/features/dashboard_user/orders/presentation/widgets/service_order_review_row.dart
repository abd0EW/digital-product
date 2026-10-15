import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ServiceOrderReviewRow extends StatelessWidget {
  const ServiceOrderReviewRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: AppText.caption(title, color: AppColors.bodyText)),
        const SizedBox(width: 12),
        Expanded(child: AppText.body(value, textAlign: TextAlign.left)),
      ],
    );
  }
}
