import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/team_member_model.dart';
import 'package:flutter/material.dart';
import 'team_member_card.dart';

class TeamMembersSliver extends StatelessWidget {
  const TeamMembersSliver({required this.members, super.key});

  final List<TeamMemberModel> members;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      sliver: SliverList.builder(
        itemCount: members.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: TeamMemberCard(member: members[index]),
        ),
      ),
    );
  }
}
