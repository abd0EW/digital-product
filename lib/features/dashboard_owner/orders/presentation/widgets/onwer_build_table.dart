import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_build_row.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OnwerBuildTable extends StatelessWidget {
  const OnwerBuildTable({super.key , required this.orders});
 final List<OrderModel> orders;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppText.body('عدد الطلبات: ${orders.length}'),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppRadius.medium),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.medium),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(
                        AppColors.appBackground,
                      ),
                      columns: const [
                        DataColumn(label: Text('رقم الطلب')),
                        DataColumn(label: Text('الخدمة')),
                        DataColumn(label: Text('السعر الكلي')),
                        DataColumn(label: Text('حالة الخدمة')),
                        DataColumn(label: Text('المسؤول عن التنفيذ')),
                        DataColumn(label: Text('الإجراء')),
                      ],
                      rows: orders.map(buildRow).toList(growable: false),
                    ),
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
