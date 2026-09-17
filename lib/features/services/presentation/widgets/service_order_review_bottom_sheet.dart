import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/services/data/models/service_model.dart';
import 'package:digital_product/features/services/presentation/widgets/service_order_header.dart';
import 'package:digital_product/features/services/presentation/widgets/service_order_review_row.dart';
import 'package:flutter/material.dart';

class ServiceOrderReviewContent extends StatelessWidget {
  const ServiceOrderReviewContent({
    super.key,

    required this.service,
    required this.pagesCount,
    required this.totalPrice,
    required this.fileName,
    required this.onEdit,
    required this.onConfirm,
  });

  final ServiceModel service;
  final int pagesCount;
  final double totalPrice;
  final String? fileName;
  final VoidCallback onEdit;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ServiceOrderHeader(service: service),

        const SizedBox(height: 22),

        const Align(
          alignment: Alignment.centerRight,
          child: AppText.title('مراجعة تفاصيل الطلب'),
        ),

        const SizedBox(height: 10),

        const Divider(),

        const SizedBox(height: 12),

        ServiceOrderReviewRow(title: 'الخدمة', value: service.title),

        const SizedBox(height: 14),

        ServiceOrderReviewRow(title: 'الكمية', value: '$pagesCount صفحة'),

        const SizedBox(height: 14),

        ServiceOrderReviewRow(
          title: 'المبلغ شامل ضريبة 15%',
          value: '${totalPrice.toStringAsFixed(2)} ر.س',
        ),

        const SizedBox(height: 14),

        const ServiceOrderReviewRow(
          title: 'توقيت الدفع',
          value: 'دفع بعد اكتمال الطلب',
        ),

        const SizedBox(height: 14),

        ServiceOrderReviewRow(
          title: 'الملفات',
          value: fileName ?? 'لم يتم الرفع',
        ),

        const SizedBox(height: 22),

        Row(
          children: [
            Expanded(
              child: AppButton(
                title: 'تأكيد الطلب',
                onPressed: onConfirm,
                backgroundColor: AppColors.secondaryButtonBackground,
                foregroundColor: AppColors.primaryButtonText,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: AppButton(
                title: 'تعديل',
                onPressed: onEdit,
                backgroundColor: AppColors.cardBackground,
                foregroundColor: AppColors.bodyText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
