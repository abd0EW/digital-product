import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/features/orders/data/models/order_model.dart';
import 'package:digital_product/features/orders/presentation/views/order_details_view.dart';
import 'package:digital_product/features/orders/presentation/widgets/order_card.dart';
import 'package:digital_product/features/orders/presentation/widgets/orders_filter_chips.dart';
import 'package:digital_product/features/orders/presentation/widgets/orders_header.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  String selectedFilter = 'قيد التنفيذ';

  final List<OrderModel> orders = const [
    OrderModel(
      serviceName: 'التدقيق الإملائي',
      description: 'تصحيح الأخطاء الإملائية والكتابية بدقة عالية.',
      orderNumber: '#1119',
      quantity: '1 صفحة',
      date: 'الآن',
      time: '',
      status: OrderStatus.completed,
      price: '3',
      serviceIcon: Icons.spellcheck_rounded,
    ),
    OrderModel(
      serviceName: 'التدقيق اللغوي',
      description: 'فحص شامل للنص وتصحيح الأخطاء وتحسين الأسلوب.',
      orderNumber: '#1042',
      quantity: '10 صفحات',
      date: '28 أغسطس 2026',
      time: '',
      status: OrderStatus.inProgress,
      price: '30',
      serviceIcon: Icons.edit_note_rounded,
    ),
    OrderModel(
      serviceName: 'عروض PowerPoint',
      description: 'تصميم عروض تقديمية احترافية.',
      orderNumber: '#1038',
      quantity: '8 شرائح',
      date: '20 أغسطس 2026',
      time: '10:24 ص',
      status: OrderStatus.completed,
      price: '80',
      serviceIcon: Icons.slideshow_rounded,
      notes: 'أرجو استخدام الهوية البصرية المرفقة',
      attachmentName: 'عرض_تقديمي.pdf',
      attachmentSize: '2.4 MB',
    ),
    OrderModel(
      serviceName: 'كتابة تقارير',
      description: 'كتابة تقارير واضحة ومنظمة.',
      orderNumber: '#1031',
      quantity: '3 صفحات',
      date: '20 أغسطس 2026',
      time: '',
      status: OrderStatus.completed,
      price: '90',
      serviceIcon: Icons.article_rounded,
    ),
  ];

  List<OrderModel> get filteredOrders {
    if (selectedFilter == 'قيد التنفيذ') {
      return orders;
    }

    return orders
        .where((order) => order.status.label == selectedFilter)
        .toList();
  }

  void openOrderDetails(OrderModel order) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => OrderDetailsView(order: order)),
    );
  }

  void onFilterSelected(String filter) {
    if (selectedFilter == filter) return;

    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 8,
          backgroundColor: AppColors.appBackground,
          surfaceTintColor: AppColors.appBackground,
        ),

        body: SafeArea(
          top: false,
          child: Column(
            children: [
              OrdersHeader(orderCount: orders.length),

              OrdersFilterChips(
                selectedFilter: selectedFilter,
                onFilterSelected: onFilterSelected,
              ),

              const SizedBox(height: AppSpacing.sm),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.xl,
                  ),
                  itemCount: filteredOrders.length,
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: AppSpacing.sm);
                  },
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];

                    return OrderCard(
                      order: order,
                      onPressed: () {
                        openOrderDetails(order);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
