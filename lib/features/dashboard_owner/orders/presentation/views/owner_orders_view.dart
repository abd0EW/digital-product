import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_order_filter_chips.dart';
import 'package:digital_product/core/widgets/app_show_model_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_owner/orders/data/models/owner_order_model.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_orders_table.dart';
import 'package:digital_product/features/dashboard_owner/team/data/team_members.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/assign_worker_bottom_sheet.dart';
import 'package:flutter/material.dart';

class OwnerOrdersView extends StatefulWidget {
  const OwnerOrdersView({super.key});

  @override
  State<OwnerOrdersView> createState() => _OwnerOrdersViewState();
}

class _OwnerOrdersViewState extends State<OwnerOrdersView> {
  String selectedFilter = 'جديد';

  static const List<OwnerOrderModel> initialOrders = [
    OwnerOrderModel(
      customerName: 'أحمد الزهراني',
      serviceName: 'التدقيق اللغوي',
      amount: '30',
      status: ' قيد التنفيذ',
      orderNumber: '#1042',
    ),
    OwnerOrderModel(
      customerName: 'سارة العتيبي',
      serviceName: 'عروض PowerPoint',
      amount: '120',
      status: ' قيد التنفيذ',
      orderNumber: '#1038',
    ),
    OwnerOrderModel(
      customerName: 'سارة العتيبي',
      serviceName: 'عروض PowerPoint',
      amount: '120',
      status: ' قيد التنفيذ',
      orderNumber: '#1039',
    ),
    OwnerOrderModel(
      customerName: 'سارة العتيبي',
      serviceName: 'عروض PowerPoint',
      amount: '120',
      status: 'مكتمل',
      orderNumber: '#1031',
    ),
    OwnerOrderModel(
      customerName: 'سارة العتيبي',
      serviceName: 'عروض PowerPoint',
      amount: '120',
      status: 'مكتمل',
      orderNumber: '#1030',
    ),
    OwnerOrderModel(
      customerName: 'نورة القحطاني',
      serviceName: 'تلخيص الأبحاث',
      amount: '75',
      status: 'جديد',
      orderNumber: '#1071',
    ),
    OwnerOrderModel(
      customerName: 'خالد المطيري',
      serviceName: 'إدخال بيانات',
      amount: '50',
      status: 'جديد',
      orderNumber: '#1072',
    ),
  ];

  late List<OwnerOrderModel> orders = initialOrders;

  static const List<String> orderFilters = [
    'جديد',
    'قيد التنفيذ',
    'بانتظار الدفع',
    'مكتمل',
    'مرفوض',
  ];

  List<OwnerOrderModel> get filteredOrders {
    return orders
        .where((element) => element.status.trim() == selectedFilter)
        .toList();
  }

  void _openAssignWorkerSheet(OwnerOrderModel order) {
    final workers = teamMembers.where((member) => !member.isOwner).toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => AssignWorkerBottomSheet(
        order: order,
        workers: workers,
        onConfirmed: (worker) {
          setState(() {
            final index = orders.indexOf(order);
            if (index == -1) return;
            orders[index] = order.copyWith(
              status: 'قيد التنفيذ',
              assignedWorkerId: worker.email,
              assignedWorkerName: worker.name,
            );
            selectedFilter = 'قيد التنفيذ';
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        AppOrderFilterChips(
          selectedFilter: selectedFilter,
          filters: orderFilters,
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: AppSpacing.md),
              OwnerOrdersTable(
                orders: filteredOrders,
                onAssignWorker: selectedFilter == 'جديد'
                    ? _openAssignWorkerSheet
                    : null,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
