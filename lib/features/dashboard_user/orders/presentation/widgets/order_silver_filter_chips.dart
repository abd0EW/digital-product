import 'package:digital_product/core/utils/order_filter_option.dart';
import 'package:digital_product/core/widgets/app_order_filter_chips.dart';
import 'package:flutter/material.dart';

class OrderSilverFilterChips extends StatelessWidget {
  const OrderSilverFilterChips({
    super.key,
    required this.selectedStatus,
    required this.onFilterSelected,
  });

  final String? selectedStatus;
  final ValueChanged<String?> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final selectedOption = orderFilterOptions.firstWhere(
      (option) => option.status == selectedStatus,
      orElse: () => orderFilterOptions.first,
    );

    return AppOrderFilterChips(
      selectedFilter: selectedOption.label,
      filters: orderFilterOptions
          .map((option) => option.label)
          .toList(growable: false),
      onFilterSelected: (label) {
        final option = orderFilterOptions.firstWhere(
          (option) => option.label == label,
        );
        onFilterSelected(option.status);
      },
    );
  }
}
