import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/create_order_header.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/service_order_review_row.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class CreateOrderReviewBottomSheet extends StatelessWidget {
  const CreateOrderReviewBottomSheet({
    super.key,
    required this.service,
    required this.totalPrice,
    required this.pageCount,
    required this.onEdit,
    required this.onConfirm,
    required this.isSubmitting,
  });

  final ServiceModel service;
  final double? totalPrice;
  final int? pageCount;
  final VoidCallback onEdit;
  final VoidCallback onConfirm;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CreateOrderHeader(service: service),

        const SizedBox(height: 22),

        const Align(
          alignment: Alignment.centerRight,
          child: AppText.title(
            'مراجعة تفاصيل الطلب',
            color: AppColors.headingText,
          ),
        ),

        const SizedBox(height: 10),

        const Divider(),

        const SizedBox(height: 12),

        ServiceOrderReviewRow(title: 'الكمية', value: '$pageCount صفحة'),

        const SizedBox(height: 14),

        ServiceOrderReviewRow(
          title: 'المبلغ',
          value: '${totalPrice ?? 0} ${service.currency}',
        ),

        const SizedBox(height: 14),

        const ServiceOrderReviewRow(
          title: 'توقيت الدفع',
          value: 'دفع بعد اكتمال الطلب',
        ),

        const SizedBox(height: 14),

        ServiceOrderReviewRow(title: 'الملفات', value: service.nameAr),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 52,
                child: isSubmitting
                    ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryButtonBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.3,
                            color: AppColors.primaryButtonText,
                          ),
                        ),
                      )
                    : AppButton(
                        width: double.infinity,
                        title: 'تأكيد الطلب',
                        onPressed: onConfirm,
                        backgroundColor: AppColors.secondaryButtonBackground,
                        foregroundColor: AppColors.primaryButtonText,
                      ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: SizedBox(
                height: 52,
                child: AppButton(
                  width: double.infinity,
                  title: 'تعديل',
                  onPressed: isSubmitting ? null : onEdit,
                  backgroundColor: AppColors.cardBackground,
                  foregroundColor: AppColors.bodyText,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
