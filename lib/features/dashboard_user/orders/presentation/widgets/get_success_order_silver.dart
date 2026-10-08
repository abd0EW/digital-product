import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';

class GetSuccessOrderSilver extends StatelessWidget {
  const GetSuccessOrderSilver({
    super.key,
    required this.orders,
    required this.onOrderPressed,
  });
  final List<OrderModel> orders;
  final void Function(OrderModel) onOrderPressed;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      sliver: SliverList.separated(
        itemCount: orders.length,
        separatorBuilder: (_, _) => const SizedBox(height: 2),
        itemBuilder: (context, index) {
          final order = orders[index];
          return OrderCard(
            order: order,
            onPressed: order.status.trim().toLowerCase() == 'rejected'
                ? null
                : () => onOrderPressed(order),
          );
        },
      ),
    );
  }
}
