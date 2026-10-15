import 'package:digital_product/features/dashboard_user/notifications/presentation/viewmodels/cubit/notification_cubit.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/widgets/notifications_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:digital_product/core/di/service_locator.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationCubit>(
      create: (_) => ServiceLocator.sl<NotificationCubit>()..getNotification(),
      child: const NotificationsBody(),
    );
  }
}
