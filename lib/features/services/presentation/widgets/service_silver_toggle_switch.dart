import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_animated_child.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ServiceSilverToggleSwitch extends StatefulWidget {
  ServiceSilverToggleSwitch({super.key, required this.selectedIndex});
  int? selectedIndex;

  @override
  State<ServiceSilverToggleSwitch> createState() =>
      _ServiceSilverToggleSwitchState();
}

class _ServiceSilverToggleSwitchState extends State<ServiceSilverToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AppAnimatedChild(
              child: ToggleSwitch(
                initialLabelIndex: widget.selectedIndex ?? 0,
                totalSwitches: 2,
                minWidth: constraints.maxWidth / 2,
                minHeight: 38,
                labels: const ['الخدمات العامة', 'الخدمات التعليمية'],
                activeBgColor: [AppColors.navyPrimary],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.transparent,
                inactiveFgColor: AppColors.navyPrimary,
                borderWidth: 0,
                dividerColor: Colors.transparent,
                cornerRadius: 13,
                radiusStyle: true,
                fontSize: 12,
                onToggle: (index) {
                  if (index == null) return;
                  setState(() {
                    widget.selectedIndex = index;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
