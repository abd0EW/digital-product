import 'package:digital_product/core/widgets/app_fail_state_silver.dart';
import 'package:digital_product/core/widgets/app_loading_state_silver.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/onwer_build_table.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerOrdersTable extends StatelessWidget {
  const OwnerOrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderCubit, GetOrderState>(
      builder: (context, state) {
        if (state is GetOrderInitial || state is GetOrderLoading) {
          return const AppLoadingStateSilver();
        }

        if (state is GetOrderFailure) {
          return AppFailStateSilver(failureMessage: state.message);
        }

        if (state is GetOrderEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: AppText.body('لا توجد طلبات ضمن هذا التصنيف')),
          );
        }

        if (state is GetOrderSuccess) {
          return OnwerBuildTable(orders: state.orders);
        }

        return const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: AppText.body('لا توجد طلبات')),
        );
      },
    );
  }

}
