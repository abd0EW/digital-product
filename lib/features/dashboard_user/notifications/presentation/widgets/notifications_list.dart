import 'package:digital_product/features/dashboard_user/notifications/presentation/viewmodels/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';

import 'package:digital_product/features/dashboard_user/notifications/data/models/notification_model.dart';

import 'package:digital_product/features/dashboard_user/notifications/presentation/widgets/notification_card.dart';

import 'package:digital_product/features/dashboard_user/orders/presentation/views/order_details_view.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key, required this.state});

  final NotificationSuccess state;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppSpacing.md),
      sliver: SliverList.builder(
        itemCount: state.notificationModel.length,
        itemBuilder: (context, index) {
          final notification = state.notificationModel[index];

          return Padding(
            key: ValueKey(notification.id),
            padding: const EdgeInsets.only(bottom: 10),
            child: NotificationCard(notification: notification, onTap: () {}),
          );
        },
      ),
    );
  }
}
