import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class ServiceNotesField extends StatelessWidget {
  const ServiceNotesField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText.title('ملاحظات (اختياري)', color: AppColors.headingText),

        const SizedBox(height: 8),

        AppTextField(controller: controller),
      ],
    );
  }
}
