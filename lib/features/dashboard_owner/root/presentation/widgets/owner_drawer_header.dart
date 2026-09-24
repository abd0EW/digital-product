import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OwnerDrawerHeader extends StatelessWidget {
  const OwnerDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              AppText.caption("منصه"),
              AppText.title(" منصه الخدمات الرقميه ", color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
