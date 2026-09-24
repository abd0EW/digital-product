import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_btn.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_attachments_card.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_price_summary_card.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_summary_card.dart';
import 'package:flutter/material.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({required this.order, super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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

                  OrderAttachmentsCard(order: order),

                  const SizedBox(height: AppSpacing.sm),

                  OrderPriceSummaryCard(),
                ]),
              ),
            ),
          ],
        ),

        bottomSheet: AppBottomSheetBtn(title: 'اعاده الطلب '),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      toolbarHeight: 50,
      title: const AppText.title('تفاصيل الطلب'),
      backgroundColor: AppColors.appBackground,
      surfaceTintColor: AppColors.appBackground,
    );
  }
}
