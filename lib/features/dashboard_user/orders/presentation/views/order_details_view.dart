import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_btn.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/utils/order_display_formatter.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_attachment_card.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_price_summary_card.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_summary_card.dart';
import 'package:flutter/material.dart';

import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_btn.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_price_summary_card.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({
    required this.order,
    required this.onReorder,
    required this.onPayNow,
    super.key,
  });

  final OrderModel order;
  final VoidCallback? onReorder;
  final VoidCallback? onPayNow;

  String get _status => order.status.trim().toLowerCase();

  _OrderDetailsAction get _action {
    switch (_status) {
      case 'completed':
        return _OrderDetailsAction(label: 'إعادة طلب', onPressed: onReorder);

      case 'pending':
        return _OrderDetailsAction(label: 'ادفع الآن', onPressed: onPayNow);

      default:
        return const _OrderDetailsAction(label: 'لا يتوفر إجراء');
    }
  }

  @override
  Widget build(BuildContext context) {
    final action = _action;

    return BlocProvider<GetOrderFilesCubit>(
      create: (_) =>
          ServiceLocator.sl<GetOrderFilesCubit>()
            ..getOrderFiles(orderId: order.id!),
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            _buildAppBar(),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                110,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  OrderSummaryCard(order: order),

                  const SizedBox(height: AppSpacing.sm),

                  OrderPriceSummaryCard(order: order),

                  const SizedBox(height: AppSpacing.sm),

                  if (order.id != null) const OrderAttachmentCard(),
                ]),
              ),
            ),
          ],
        ),
        bottomSheet: switch (_status) {
          'rejected' => null,
          'in_progress' => const _OrderInProgressMessage(),
          _ => AppBottomSheetBtn(
            title: action.label,
            onPressed: action.onPressed,
            disabled: action.onPressed == null,
          ),
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return const SliverAppBar(
      pinned: true,
      centerTitle: true,
      toolbarHeight: 50,
      title: AppText.title('تفاصيل الطلب'),
      backgroundColor: AppColors.appBackground,
      surfaceTintColor: AppColors.appBackground,
    );
  }
}

class _OrderDetailsAction {
  const _OrderDetailsAction({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;
}

class _OrderInProgressMessage extends StatefulWidget {
  const _OrderInProgressMessage();

  @override
  State<_OrderInProgressMessage> createState() =>
      _OrderInProgressMessageState();
}

class _OrderInProgressMessageState extends State<_OrderInProgressMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(curved);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curved);

    _scaleAnimation = Tween<double>(begin: 0.94, end: 1).animate(curved);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.secondaryButtonBackground,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: AppText.caption(
                            'جاري العمل على طلبك، وسيصلك إشعار على بريدك الإلكتروني فور اكتمال الخدمة.',
                            color: AppColors.appBackground,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
