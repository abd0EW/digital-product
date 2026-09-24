import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_summary_card.dart';
import 'package:flutter/material.dart';

class OrderAttachmentsCard extends StatelessWidget {
  const OrderAttachmentsCard({required this.order, super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.title('الملفات المرفقة'),
          const SizedBox(height: AppSpacing.sm),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              const Icon(
                Icons.picture_as_pdf_rounded,
                color: AppColors.warning,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.title(
                      order.attachmentName ?? 'عرض_تقديمي.pdf',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppText.caption(
                      order.attachmentSize ?? '2.4 MB',
                      color: AppColors.bodyText,
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.visibility_outlined, size: 17),
                label: const AppText.body('عرض الملف'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
