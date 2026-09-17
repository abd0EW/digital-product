import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/orders/data/models/order_model.dart';
import 'package:digital_product/features/orders/presentation/widgets/order_attachments_card.dart';
import 'package:digital_product/features/orders/presentation/widgets/order_price_summary_card.dart';
import 'package:digital_product/features/orders/presentation/widgets/order_summary_card.dart';
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

        bottomSheet: _buildBottomAction(),
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

  Widget _buildBottomAction() {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.appBackground,
          border: Border(
            top: BorderSide(
              color: AppColors.headingText.withValues(alpha: 0.08),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: AppButton(
          width: double.infinity,
          title: 'إعادة الطلب',
          onPressed: () {},
          backgroundColor: AppColors.secondaryButtonBackground,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
