import 'package:digital_product/core/widgets/app_header_view.dart';
import 'package:flutter/material.dart';

class OrderSilverHeader extends StatelessWidget {
  const OrderSilverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 0, left: 10, right: 10),
      sliver: SliverToBoxAdapter(child: AppHeaderView(textHedader: 'طلباتي')),
    );
  }
}
