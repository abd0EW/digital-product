import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/team_member_model.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/viewmodels/invite_worker_cubit/invite_worker_cubit.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/viewmodels/worker_invitations_cubit/get_workers_cubit.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/widgets/add_assistant_sliver.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/widgets/team_header_sliver.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/widgets/team_members_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerTeamView extends StatefulWidget {
  const OwnerTeamView({super.key});

  @override
  State<OwnerTeamView> createState() => _OwnerTeamViewState();
}

class _OwnerTeamViewState extends State<OwnerTeamView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isAddingAssistant = false;
  late final GetWorkersCubit _workerInvitationsCubit;
  late final InviteWorkerCubit _inviteWorkerCubit;

  @override
  void initState() {
    super.initState();
    _workerInvitationsCubit = ServiceLocator.sl<GetWorkersCubit>()
      ..loadWorkerInvitations();
    _inviteWorkerCubit = ServiceLocator.sl<InviteWorkerCubit>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _workerInvitationsCubit.close();
    _inviteWorkerCubit.close();
    super.dispose();
  }

  void _toggleAssistantForm() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _isAddingAssistant = !_isAddingAssistant);
  }

  void _addAssistant() {
    FocusManager.instance.primaryFocus?.unfocus();
    _inviteWorkerCubit.inviteWorker(
      fullName: _nameController.text,
      email: _emailController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _workerInvitationsCubit),
        BlocProvider.value(value: _inviteWorkerCubit),
      ],
      child: BlocListener<InviteWorkerCubit, InviteWorkerState>(
        listener: (context, state) {
          if (state is InviteWorkerSuccess) {
            _workerInvitationsCubit.loadWorkerInvitations();
            _nameController.clear();
            _emailController.clear();
            setState(() => _isAddingAssistant = false);
            AppSnackbar.success(context, message: "تم دعوه العامل بنجاح");
          } else if (state is InviteWorkerFailure) {
            AppSnackbar.error(context, message: state.message);
          }
        },
        child: Scaffold(
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
                BlocBuilder<GetWorkersCubit, GetWorkersState>(
                  builder: (context, state) {
                    if (state is GetWorkersStateLoading) {
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is GetWorkersStateFailure) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text(state.message)),
                      );
                    }

                    if (state is GetWorkersStateSuccess) {
                      final members = state.invitations
                          .map(
                            (invitation) => TeamMemberModel(
                              name: invitation.fullName,
                              email: invitation.email,
                              role: 'عامل مدعو',
                              initial: invitation.fullName.isEmpty
                                  ? '؟'
                                  : invitation.fullName[0],
                            ),
                          )
                          .toList(growable: false);
                      return TeamMembersSliver(members: members);
                    }

                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.xl),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
