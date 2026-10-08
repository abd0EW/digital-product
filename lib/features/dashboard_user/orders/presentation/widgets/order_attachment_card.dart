import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';

import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_state.dart';

class OrderAttachmentCard extends StatelessWidget {
  const OrderAttachmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderFilesCubit, GetOrderFilesState>(
      builder: (context, state) {
        if (state is GetOrderFilesLoading || state is GetOrderFilesInitial) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is GetOrderFilesEmpty) {
          return const SizedBox.shrink();
        }

        if (state is GetOrderFilesFailure) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppText.caption(state.message, color: AppColors.bodyText),
          );
        }

        if (state is GetOrderFilesSuccess) {
          if (state.files.isEmpty) {
            return const SizedBox.shrink();
          }

          return Container(
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
                const AppText.title(
                  'مرفقات الطلب',
                  color: AppColors.headingText,
                ),

                const SizedBox(height: 16),

                ...state.files.map(
                  (file) => Padding(
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

                          const Icon(
                            Icons.attach_file_rounded,
                            color: AppColors.bodyText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
