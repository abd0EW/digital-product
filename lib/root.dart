import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/features/notifications/presentation/views/notifications_view.dart';
import 'package:digital_product/features/orders/presentation/views/orders_view.dart';
import 'package:digital_product/features/profile/presentation/views/profile_view.dart';
import 'package:digital_product/features/services/presentation/views/services_view.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentIndex = 0;

  late final PageController _pageController;

  static const List<Widget> _pages = [
    ServicesView(),
    OrdersView(),
    NotificationsView(),
    ProfileView(),
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

    setState(() {
      currentIndex = index;
    });

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

      // يخلي الصفحة تمتد ورا الـ floating bottom nav
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if (currentIndex != index) {
            setState(() {
              currentIndex = index;
            });
          }
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            _navItem(
              index: 0,
              label: 'الخدمات',
              icon: Icons.grid_view_outlined,
              selectedIcon: Icons.grid_view_rounded,
            ),
            _navItem(
              index: 1,
              label: 'طلباتي',
              icon: Icons.description_outlined,
              selectedIcon: Icons.description_rounded,
            ),
            _navItem(
              index: 2,
              label: 'الإشعارات',
              icon: Icons.notifications_none_rounded,
              selectedIcon: Icons.notifications_rounded,
            ),
            _navItem(
              index: 3,
              label: 'حسابي',
              icon: Icons.person_outline_rounded,
              selectedIcon: Icons.person_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String label,
    required IconData icon,
    required IconData selectedIcon,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _changePage(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                scale: isSelected ? 1.08 : 1,
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  size: 22,
                  color: isSelected
                      ? AppColors.secondaryButtonBackground
                      : const Color(0xFF8298B8),
                ),
              ),

              const SizedBox(height: 5),

              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : const Color(0xFF8298B8),
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
