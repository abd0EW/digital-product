import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/models/notification_ui_model.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  static const List<NotificationUiModel> _notifications = [
    NotificationUiModel(
      title: 'طلبك #1042 قيد التنفيذ',
      description: 'بدأ الفريق العمل على طلب التدقيق اللغوي الخاص بك',
      time: 'منذ ساعتين',
      type: NotificationUiType.inProgress,
      isRead: false,
    ),
    NotificationUiModel(
      title: 'طلبك #1038 جاهز للدفع',
      description: 'طلبك جاهز أكمل الدفع لاستلام الملفات النهائية',
      time: 'منذ 5 ساعات',
      type: NotificationUiType.payment,
      isRead: false,
    ),
    NotificationUiModel(
      title: 'تم اكتمال طلبك #1031',
      description: 'يمكنك الآن تحميل الملفات النهائية',
      time: 'منذ يومين',
      type: NotificationUiType.completed,
      isRead: true,
    ),
    NotificationUiModel(
      title: 'مرحباً بك في المنصة',
      description: 'يسعدنا انضمامك، استكشف خدماتنا المتنوعة',
      time: 'منذ أسبوع',
      type: NotificationUiType.welcome,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.md,
                  0,
                ),
                sliver: SliverToBoxAdapter(child: AppText.title('الإشعارات')),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final notification = _notifications[index];
                    final isLast = index == _notifications.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: isLast ? 0 : AppSpacing.sm,
                      ),
                      child: NotificationCard(notification: notification),
                    );
                  }, childCount: _notifications.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
