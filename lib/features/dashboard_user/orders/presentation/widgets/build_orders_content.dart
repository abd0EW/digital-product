import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_state_loading.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_state.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/get_success_order_silver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildOrdersContent extends StatelessWidget {
  const BuildOrdersContent({required this.onOrderPressed, super.key});

  final ValueChanged<OrderModel> onOrderPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderCubit, GetOrderState>(
      builder: (context, state) {
        if (state is GetOrderInitial || state is GetOrderLoading) {
          return const appLoadingState();
        }

        if (state is GetOrderFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.sm),
                  FilledButton.icon(
                    onPressed: context.read<GetOrderCubit>().getOrders,
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is GetOrderEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text('لا توجد طلبات')),
          );
        }

        if (state is GetOrderSuccess) {
          final orders = state.orders;

          if (orders.isEmpty) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('لا توجد طلبات ضمن هذا التصنيف')),
            );
          }

          return GetSuccessOrderSilver(
            orders: orders,
            onOrderPressed: onOrderPressed,
          );
        }

        return const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: Text('لا توجد طلبات')),
        );
      },
    );
  }
}
