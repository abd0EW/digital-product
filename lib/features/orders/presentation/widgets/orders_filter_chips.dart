import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OrdersFilterChips extends StatelessWidget {
  const OrdersFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  static const List<String> filters = [
    'قيد التنفيذ',
    'بانتظار الدفع',
    'مكتمل',
    'مرفوض',
  ];

  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,

      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: AppSpacing.sm);
        },
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;
          return _FilterChip(
            title: filter,
            isSelected: isSelected,
            onTap: () => onFilterSelected(filter),
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.navyPrimary : AppColors.cardBackground,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.navyPrimary : AppColors.cardBorder,
            ),
          ),
          alignment: Alignment.center,
          child: AppText.switches(
            title,
            color: isSelected ? AppColors.whiteText : AppColors.bodyText,
          ),
        ),
      ),
    );
  }
}
