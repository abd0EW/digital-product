import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/service_notes_field.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/service_order_header.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/service_pages_counter.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/service_price_summary.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/service_upload_file.dart';
import 'package:flutter/material.dart';

class BuildOrderContent extends StatelessWidget {
  const BuildOrderContent({
    super.key,
    required this.service,
    required this.pagesCount,
    required this.totalPrice,
    required this.notesController,
    required this.fileName,
    required this.isUploaded,
    required this.onIncrement,
    required this.onDecrement,
    required this.onUploadFile,
    required this.onReview,
  });

  final ServiceModel service;
  final int pagesCount;
  final double totalPrice;

  final TextEditingController notesController;

  final String? fileName;
  final bool isUploaded;

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onUploadFile;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ServiceOrderHeader(service: service),

        const SizedBox(height: 22),

        ServicePagesCounter(
          pagesCount: pagesCount,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
        ),

        const SizedBox(height: 22),

        ServiceNotesField(controller: notesController),

        const SizedBox(height: 22),

        ServiceUploadFile(
          isUploaded: isUploaded,
          fileName: fileName,
          onTap: onUploadFile,
        ),

        const SizedBox(height: 18),

        ServicePriceSummary(totalPrice: totalPrice),

        const SizedBox(height: 18),

        SizedBox(
          width: double.infinity,
          child: AppButton(
            title: 'مراجعة الطلب',
            onPressed: onReview,
            backgroundColor: AppColors.primaryButtonBackground,
            foregroundColor: AppColors.primaryButtonText,
          ),
        ),
      ],
    );
  }
}
