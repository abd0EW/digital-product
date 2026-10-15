import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/viewmodels/owner_update_services_cubit/owner_update_services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerSericesCardSwitch extends StatelessWidget {
  const OwnerSericesCardSwitch({
    super.key,
    required this.id,
    required this.isEnabled,
  });

  final String id;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      OwnerUpdateServicesCubit,
      OwnerUpdateServicesState,
      ({bool isSaving, bool value})
    >(
      selector: (state) => (
        value: state.changedServices[id] ?? state.savedServices[id] ?? isEnabled,
        isSaving: state is OwnerUpdateServicesSaving,
      ),
      builder: (context, switchState) {
        return Switch(
          value: switchState.value,
          onChanged: switchState.isSaving
              ? null
              : (value) => context
                    .read<OwnerUpdateServicesCubit>()
                    .changeServiceStatus(id: id, isActive: value),
          activeTrackColor: AppColors.success,
          inactiveThumbColor: AppColors.cardBackground,
          inactiveTrackColor: AppColors.cardBorder,
        );
      },
    );
  }
}
