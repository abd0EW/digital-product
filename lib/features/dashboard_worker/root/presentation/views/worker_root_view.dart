import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/views/notifications_view.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/views/profile_view.dart';
import 'package:digital_product/features/dashboard_worker/dashboard/presentation/views/worker_dashboard_view.dart';
import 'package:digital_product/features/dashboard_worker/orders/presentation/views/worker_orders_view.dart';
import 'package:flutter/material.dart';

class WorkerRootView extends StatefulWidget {
  const WorkerRootView({super.key});

  @override
  State<WorkerRootView> createState() => _WorkerRootViewState();
}

class _WorkerRootViewState extends State<WorkerRootView> {
  int currentIndex = 0;
  late final PageController _pageController;

  static const List<Widget> _pages = [
    WorkerDashboardView(),
    WorkerOrdersView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    if (currentIndex == index) return;
    setState(() => currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if (currentIndex != index) setState(() => currentIndex = index);
        },
        physics: const BouncingScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.navyDark.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: Row(
          children: [
            _navItem(0, 'الرئيسية', Icons.home_outlined, Icons.home_rounded),
            _navItem(
              1,
              'الطلبات',
              Icons.description_outlined,
              Icons.description_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    int index,
    String label,
    IconData icon,
    IconData selectedIcon,
  ) {
    final isSelected = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _changePage(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              size: 22,
              color: isSelected
                  ? AppColors.secondaryButtonBackground
                  : const Color(0xFF8298B8),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : const Color(0xFF8298B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
