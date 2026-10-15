import 'package:digital_product/features/dashboard_user/notifications/presentation/viewmodels/cubit/notification_cubit.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/widgets/notifications_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.tealPrimary,
          onRefresh: () => cubit.getNotification(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.md,
                  20,
                ),
                sliver: SliverToBoxAdapter(child: AppText.title('الإشعارات')),
              ),

              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  return NotificationsContent(state: state);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
