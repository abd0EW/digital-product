import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppOrderFilterChips extends StatelessWidget {
  const AppOrderFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    this.filters = defaultFilters,
  });

  static const List<String> defaultFilters = [
    'قيد التنفيذ',
    'بانتظار الدفع',
    'مكتمل',
    'مرفوض',
  ];

  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;
  final List<String> filters;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          height: 35,

          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, _) {
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
        ),
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
