import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/team_member_model.dart';
import 'package:flutter/material.dart';

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({required this.member, super.key});

  final TeamMemberModel member;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              spreadRadius: 0,

              offset: const Offset(0, 3),
            ),
          ],
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primaryButtonBackground,
              child: AppText.title(
                member.initial,
                color: AppColors.appBackground,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title(member.name, maxLines: 1),

                  AppText.caption(
                    member.email,
                    maxLines: 1,
                    color: AppColors.bodyText,
                  ),

                  AppText.body(
                    member.role,
                    maxLines: 1,
                    color: AppColors.secondaryButtonBackground,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
