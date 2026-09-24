import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ServiceUploadFile extends StatelessWidget {
  const ServiceUploadFile({
    super.key,
    required this.onTap,
    required this.isUploaded,
    this.fileName,
  });

  final VoidCallback onTap;
  final bool isUploaded;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText.title('رفع ملف', color: AppColors.headingText),

        const SizedBox(height: 8),

        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isUploaded
                  ? AppColors.successBackground
                  : AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isUploaded ? AppColors.success : AppColors.inputBorder,
              ),
            ),
            child: isUploaded
                ? Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: AppColors.success,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.body(
                              fileName ?? 'الملف',
                              color: AppColors.headingText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 3),

                            const AppText.caption(
                              'تم الرفع',
                              color: AppColors.success,
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: AppColors.bodyText,
                      ),
                    ],
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 18,
                        color: AppColors.bodyText,
                      ),

                      SizedBox(width: 8),

                      AppText.body(
                        'اضغط لرفع الملف',
                        color: AppColors.bodyText,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
