import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_btn.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_attachment_card.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_in_progress_message.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_price_summary_card.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_summary_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({
    required this.order,
    required this.onPayNow,
    super.key,
  });

  final OrderModel order;
  final VoidCallback? onPayNow;

  String get _status => order.status.trim().toLowerCase();

  _OrderDetailsAction get _action {
    switch (_status) {
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
                20,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  OrderSummaryCard(order: order),

                  const SizedBox(height: AppSpacing.sm),

                  OrderPriceSummaryCard(order: order),
                ]),
              ),
            ),

            const OrderAttachmentCard(),
          ],
        ),
        bottomSheet: switch (_status) {
          'rejected' => null,
          'completed' => null,
          'in_progress' => const OrderInProgressMessage(),
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
