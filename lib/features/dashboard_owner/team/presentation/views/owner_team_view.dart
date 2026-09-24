import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_owner/team/data/team_members.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/widgets/add_assistant_sliver.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/widgets/team_header_sliver.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/widgets/team_members_sliver.dart';
import 'package:flutter/material.dart';

class OwnerTeamView extends StatefulWidget {
  const OwnerTeamView({super.key});

  @override
  State<OwnerTeamView> createState() => _OwnerTeamViewState();
}

class _OwnerTeamViewState extends State<OwnerTeamView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isAddingAssistant = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleAssistantForm() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isAddingAssistant = !_isAddingAssistant);
  }

  void _addAssistant() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isAddingAssistant = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            TeamHeaderSliver(
              isAddingAssistant: _isAddingAssistant,
              onAddAssistant: _toggleAssistantForm,
            ),
            AddAssistantSliver(
              isVisible: _isAddingAssistant,
              nameController: _nameController,
              emailController: _emailController,
              onSubmit: _addAssistant,
              onCancel: _toggleAssistantForm,
            ),
            const TeamMembersSliver(members: teamMembers),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
          ],
        ),
      ),
    );
  }
}
