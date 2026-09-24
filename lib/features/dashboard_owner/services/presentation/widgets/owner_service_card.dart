import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_service_icon.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/services/data/models/owner_service_model.dart';
import 'package:flutter/material.dart';

class OwnerServiceCard extends StatefulWidget {
  const OwnerServiceCard({
    required this.service,
    required this.onEdit,
    super.key,
  });

  final OwnerServiceModel service;
  final VoidCallback onEdit;

  @override
  State<OwnerServiceCard> createState() => _OwnerServiceCardState();
}

class _OwnerServiceCardState extends State<OwnerServiceCard> {
  late bool isEnabled = widget.service.isEnabled;

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
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText.title(widget.service.name, maxLines: 1),
                    const SizedBox(height: AppSpacing.xs),
                    AppText.caption(
                      '${widget.service.price} ر.س / ${widget.service.unit}',
                      color: AppColors.tealPrimary,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    AppText.caption(
                      widget.service.paymentInfo,
                      color: AppColors.bodyText,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: AppSpacing.sm),
            AppServiceIcon(serviceName: widget.service.name),

            Column(
              children: [
                Switch(
                  value: isEnabled,
                  onChanged: (value) {
                    setState(() {
                      isEnabled = value;
                    });
                  },
                  activeTrackColor: AppColors.success,
                  inactiveThumbColor: AppColors.cardBackground,
                  inactiveTrackColor: AppColors.cardBorder,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
