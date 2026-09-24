import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/view_model/services/services_cubit.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/view_model/services/services_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ServicesSilverToggle extends StatelessWidget {
  const ServicesSilverToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ServicesCubit, ServicesState, int>(
      selector: (state) {
        if (state is ServicesSuccess) {
          return state.toggleIndex;
        }

        return 0;
      },
      builder: (context, selectedIndex) {
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
                    activeBgColor: const [AppColors.navyPrimary],
                    activeFgColor: AppColors.whiteText,
                    inactiveBgColor: Colors.transparent,
                    inactiveFgColor: AppColors.bodyText,
                    borderWidth: 0,
                    dividerColor: Colors.transparent,
                    cornerRadius: 10,
                    radiusStyle: true,
                    fontSize: 13,
                    onToggle: (index) {
                      if (index == null) return;
                      context.read<ServicesCubit>().changeToggle(index);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
