import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ServicesSilverToggle extends StatelessWidget {
  const ServicesSilverToggle({
    super.key,
    required this.selectedIndex,
    required this.onToggleChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onToggleChanged;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ToggleSwitch(
                initialLabelIndex: selectedIndex,
                totalSwitches: 2,

                minWidth: constraints.maxWidth / 2,
                minHeight: 42,

                labels: const ['الخدمات العامة', 'الخدمات التعليمية'],

                // Selected
                activeBgColor: const [AppColors.navyPrimary],
                activeFgColor: AppColors.whiteText,

                // Unselected
                inactiveBgColor: Colors.transparent,
                inactiveFgColor: AppColors.bodyText,

                borderWidth: 0,
                dividerColor: Colors.transparent,

                cornerRadius: 10,
                radiusStyle: true,

                fontSize: 13,

                onToggle: (index) {
                  if (index == null) return;

                  onToggleChanged(index);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
