import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundAppGlass extends StatelessWidget {
  BackgroundAppGlass({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// ==========================================
        /// Main Background
        /// ==========================================
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryButtonBackground.withOpacity(.88),
                  AppColors.primaryButtonBackground.withOpacity(.82),
                  AppColors.primaryButtonBackground.withOpacity(.76),
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
