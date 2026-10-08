import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({
    super.key,
    required this.isSaving,
  });

  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: isSaving
              ? null
              : () {
                  Navigator.of(context).pop();
                },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        const AppText.title(
          'تعديل الملف الشخصي',
        ),
      ],
    );
  }
}