import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/core/utils/show_before_payment_bottom_sheet.dart';
import 'package:digital_product/core/widgets/app_state_loading_silver.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/viewmodels/cubit/notification_cubit.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/widgets/notification_card.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/widgets/notifications_empty_view.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/views/order_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_error_view.dart';

class NotificationsContent extends StatelessWidget {
  const NotificationsContent({super.key, required this.state});

  final NotificationState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();

    if (state is NotificationLoading) {
      return const AppStateLoadingSilver();
    }

    if (state is NotificationFailure) {
      final failure = state as NotificationFailure;

      return SliverFillRemaining(
        hasScrollBody: false,
        child: NotificationsErrorView(
          message: failure.messageFailure,
          onRetry: () => cubit.getNotification(),
        ),
      );
    }

    if (state is NotificationSuccess) {
      final notificationList = cubit.notifications;

      if (notificationList.isEmpty) {
        return const SliverToBoxAdapter(child: NotificationsEmptyView());
      }

      return SliverList.builder(
        addAutomaticKeepAlives: true,
        itemBuilder: (context, index) => NotificationCard(
          notification: notificationList[index],
          onTap: () {
            final order = notificationList[index].order;

            if (order == null) {
              AppSnackbar.error(
                context,
                message: 'بيانات الطلب غير متاحة حاليًا',
              );
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (routeContext) => OrderDetailsView(
                  order: order,
                  onPayNow: () {
                    final service = order.service;

                    if (service == null) {
                      AppSnackbar.error(
                        routeContext,
                        message: 'بيانات الخدمة غير متاحة حاليًا',
                      );
                      return;
                    }

                    ShowBeforePaymentBottomSheet.show(
                      context: routeContext,
                      serviceModel: service,
                    );
                  },
                ),
              ),
            );
          },
        ),
        itemCount: notificationList.length,
      );
    }

    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}
