import 'package:flutter/material.dart';
import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';

class GetOrderFileSuccessSilver extends StatelessWidget {
  const GetOrderFileSuccessSilver({
    super.key,
    required this.files,
    required this.onOpenFile,
    this.openingFilePath,
  });

  final List<OrderFileModel> files;
  final String? openingFilePath;
  final ValueChanged<String> onOpenFile;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.appBackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText.title('مرفقات الطلب', color: AppColors.headingText),
            const SizedBox(height: 16),

            ...files.map((file) {
              final isOpening = openingFilePath == file.storagePath;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.insert_drive_file_outlined,
                        color: AppColors.headingText,
                        size: 28,
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              file.fileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.headingText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const AppText.caption(
                              'ملف الطلب المرفوع',
                              color: AppColors.bodyText,
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        tooltip: 'فتح الملف',
                        onPressed: openingFilePath != null
                            ? null
                            : () => onOpenFile(file.storagePath),
                        icon: isOpening
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.attach_file_rounded,
                                color: AppColors.bodyText,
                              ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
