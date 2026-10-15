import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class OwnerServicesCardData extends StatelessWidget {
  const OwnerServicesCardData({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.title(service.nameAr, maxLines: 1),
          const SizedBox(height: AppSpacing.xs),
          AppText.caption(
            '${service.price}/ ${service.currency}',
            color: AppColors.tealPrimary,
          ),
          const SizedBox(height: AppSpacing.xs),
          AppText.caption(
            service.descriptionAr ?? "No Description For This Services",
            color: AppColors.bodyText,
          ),
        ],
      ),
    );
  }
}
