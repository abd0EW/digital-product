import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:flutter/material.dart';

class AppServiceIcon extends StatelessWidget {
  const AppServiceIcon({
    required this.serviceName,
    this.size = 48,
    this.iconSize = 24,
    super.key,
  });

  final String serviceName;
  final double size;
  final double iconSize;

  static IconData iconFor(String serviceName) {
    final normalizedName = serviceName.trim();

    if (normalizedName.contains('إملائي')) return Icons.spellcheck_rounded;
    if (normalizedName.contains('لغوي') || normalizedName.contains('تحرير')) {
      return Icons.edit_note_rounded;
    }
    if (normalizedName.contains('بيانات')) return Icons.keyboard_rounded;
    if (normalizedName.contains('PowerPoint') ||
        normalizedName.contains('عروض')) {
      return Icons.slideshow_rounded;
    }
    if (normalizedName.contains('تقرير')) return Icons.article_rounded;
    if (normalizedName.contains('بحث')) return Icons.menu_book_rounded;
    if (normalizedName.contains('واجب')) return Icons.school_rounded;
    if (normalizedName.contains('ترجم')) return Icons.translate_rounded;
    if (normalizedName.contains('تصميم')) return Icons.design_services_rounded;
    if (normalizedName.contains('سيرة')) return Icons.badge_rounded;
    if (normalizedName.contains('Excel')) return Icons.table_chart_rounded;
    if (normalizedName.contains('PDF')) return Icons.picture_as_pdf_rounded;

    return Icons.description_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.successBackground,
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: Center(
          child: Icon(
            iconFor(serviceName),
            size: iconSize,
            color: AppColors.tealPrimary,
          ),
        ),
      ),
    );
  }
}
