import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/widgets/owner_serices_card_switch.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/widgets/owner_services_card_data.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class OwnerServiceCard extends StatelessWidget {
  const OwnerServiceCard({required this.service, super.key});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OwnerServicesCardData(service: service),

          OwnerSericesCardSwitch(
            isEnabled: service.isActive,
            id: service.id,
          ),
        ],
      ),
    );
  }
}
