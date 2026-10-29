import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/viewmodels/assign_order_worker/assign_order_worker_cubit.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/worker_invitation_model.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/viewmodels/get_worker_cubit/get_workers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkerAssignmentBottomSheet extends StatelessWidget {
  const WorkerAssignmentBottomSheet({required this.orderId, super.key});

  final String orderId;

  static Future<WorkerInvitationModel?> show(
    BuildContext context, {
    required String orderId,
  }) {
    return showModalBottomSheet<WorkerInvitationModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ServiceLocator.sl<GetWorkersCubit>()..getWorkers(),
          ),
          BlocProvider(
            create: (_) => ServiceLocator.sl<AssignOrderWorkerCubit>(),
          ),
        ],
        child: WorkerAssignmentBottomSheet(orderId: orderId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssignOrderWorkerCubit, AssignOrderWorkerState>(
      listener: (context, state) {
        if (state is AssignOrderWorkerSuccess) {
          Navigator.of(context).pop(state.worker);
        } else if (state is AssignOrderWorkerFailure) {
          AppSnackbar.error(context, message: state.message);
        }
      },
      child: SafeArea(
        top: false,
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.65,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.lg,
          ),
          decoration: const BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.medium),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.cardBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const AppText.title('تعيين عامل'),
              const SizedBox(height: AppSpacing.xs),
              const AppText.body('اختر أحد العمال المقبولين للعمل معك.'),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: BlocBuilder<GetWorkersCubit, GetWorkersState>(
                  builder: (context, state) {
                    if (state is GetWorkersStateLoading ||
                        state is GetWorkersStateInitial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.tealPrimary,
                        ),
                      );
                    }

                    if (state is GetWorkersStateFailure) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText.body(state.message),
                            const SizedBox(height: AppSpacing.sm),
                            TextButton(
                              onPressed: context.read<GetWorkersCubit>().getWorkers,
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is GetWorkersStateSuccess) {
                      final workers = state.invitations
                          .where(
                            (worker) =>
                                worker.status.trim().toLowerCase() ==
                                    'accepted' &&
                                worker.acceptedUserId != null &&
                                worker.acceptedUserId!.trim().isNotEmpty,
                          )
                          .toList(growable: false);

                      if (workers.isEmpty) {
                        return const Center(
                          child: AppText.body('لا يوجد عمال مقبولون للتعيين'),
                        );
                      }

                      return BlocBuilder<
                        AssignOrderWorkerCubit,
                        AssignOrderWorkerState
                      >(
                        builder: (context, assignmentState) {
                          final isAssigning =
                              assignmentState is AssignOrderWorkerLoading;
                          return ListView.separated(
                            itemCount: workers.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: AppSpacing.sm),
                            itemBuilder: (context, index) {
                              final worker = workers[index];
                              return _WorkerOption(
                                worker: worker,
                                isEnabled: !isAssigning,
                                onTap: () => context
                                    .read<AssignOrderWorkerCubit>()
                                    .assignWorker(
                                      orderId: orderId,
                                      worker: worker,
                                    ),
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkerOption extends StatelessWidget {
  const _WorkerOption({
    required this.worker,
    required this.isEnabled,
    required this.onTap,
  });

  final WorkerInvitationModel worker;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.successBackground,
                child: Icon(Icons.person, color: AppColors.tealPrimary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.title(worker.fullName),
                    const SizedBox(height: 4),
                    AppText.caption(worker.email),
                  ],
                ),
              ),
              if (!isEnabled)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.tealPrimary,
                  ),
                )
              else
                const Icon(Icons.chevron_right, color: AppColors.bodyText),
            ],
          ),
        ),
      ),
    );
  }
}
