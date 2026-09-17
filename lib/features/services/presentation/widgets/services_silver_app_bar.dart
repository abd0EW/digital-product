import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class ServicesSilverAppbar extends StatelessWidget {
  const ServicesSilverAppbar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 12,
      title: const AppText.title(
        'الخدمات المتاحة',
        color: AppColors.headingText,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: AppTextField(
            controller: searchController,
            hintText: 'ابحث عن خدمة...',
          ),
        ),
      ),
    );
  }
}
