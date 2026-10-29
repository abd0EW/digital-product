import 'package:digital_product/core/widgets/app_fail_state_silver.dart';
import 'package:digital_product/core/widgets/app_loading_state_silver.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/team_member_model.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/viewmodels/get_worker_cubit/get_workers_cubit.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/widgets/team_members_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamMembersBlocBuilder extends StatelessWidget {
  const TeamMembersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWorkersCubit, GetWorkersState>(
      builder: (context, state) {
        if (state is GetWorkersStateLoading) {
          return const AppLoadingStateSilver();
        }

        if (state is GetWorkersStateFailure) {
          return AppFailStateSilver(failureMessage: state.message);
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
              .toList();
          return TeamMembersSliver(members: members);
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
