import 'package:digital_product/core/utils/order_filter_option.dart';
import 'package:digital_product/core/widgets/app_order_filter_chips.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerOrderFilters extends StatelessWidget {
  const OwnerOrderFilters({super.key});

  static const List<OrderFilterOption> _filters = orderFilterOptions;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderCubit, GetOrderState>(
      builder: (context, _) {
        final cubit = context.read<GetOrderCubit>();
        final selectedOption = _filters.firstWhere(
          (option) => option.status == cubit.selectedStatus,
          orElse: () => _filters.first,
        );

        return AppOrderFilterChips(
          selectedFilter: selectedOption.label,
          filters: _filters.map((option) => option.label).toList(),
          onFilterSelected: (label) {
            final option = _filters.firstWhere(
              (option) => option.label == label,
            );
            cubit.filterOrders(option.status);
          },
        );
      },
    );
  }
}
