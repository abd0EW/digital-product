import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/services/data/models/owner_service_model.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/widgets/owner_service_card.dart';
import 'package:flutter/material.dart';

class OwnerServicesSection extends StatelessWidget {
  const OwnerServicesSection({
    required this.title,
    required this.services,
    super.key,
  });

  final String title;
  final List<OwnerServiceModel> services;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AppText.switches(
              title,
              textAlign: TextAlign.right,
              color: AppColors.headingText,
            ),
          ),
          ...services.map(
            (service) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: OwnerServiceCard(service: service, onEdit: () {}),
            ),
          ),
        ]),
      ),
    );
  }
}
