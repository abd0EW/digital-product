import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_orders_content.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_fsilver_filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBodySilver extends StatefulWidget {
  const OrderBodySilver({super.key, required this.onOrderPressed});

  final ValueChanged<OrderModel> onOrderPressed;

  @override
  State<OrderBodySilver> createState() => _OrderBodySilverState();
}

class _OrderBodySilverState extends State<OrderBodySilver> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        OrderFsilverFilterChips(
          selectedStatus: selectedStatus,
          onFilterSelected: (status) {
            if (selectedStatus == status) return;

            setState(() {
              selectedStatus = status;
            });

            context.read<GetOrderCubit>().filterOrders(status);
          },
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

        BuildOrdersContent(onOrderPressed: widget.onOrderPressed),
      ],
    );
  }
}
