import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_header_view.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class PaymentSummarySliver extends StatelessWidget {
  const PaymentSummarySliver({
    required this.totalPaid,
    required this.paidCustomersCount,
    required this.onShowMore,
    super.key,
  });

  final int totalPaid;
  final int paidCustomersCount;
  final VoidCallback onShowMore;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppHeaderView(textHedader: 'المدفوعات'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AppText.body('إجمالي المدفوعات'),
                      const SizedBox(height: AppSpacing.xs),
                      AppText.title(
                        '$totalPaid ر.س',
                        color: AppColors.tealPrimary,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          const Icon(
                            Icons.people_alt_outlined,
                            color: AppColors.secondaryIcon,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          AppText.body('$paidCustomersCount عميل دفع'),
                          const Spacer(),
                          AppButton(
                            title: 'عرض المزيد',
                            onPressed: onShowMore,
                            backgroundColor: AppColors.navyPrimary,
                            foregroundColor: AppColors.whiteText,
                            height: 44,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
