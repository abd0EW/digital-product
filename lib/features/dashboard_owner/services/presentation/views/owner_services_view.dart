import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_btn.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/viewmodels/owner_get_services_cubit/owner_get_services_cubit.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/viewmodels/owner_update_services_cubit/owner_update_services_cubit.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/widgets/owner_services_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerServicesView extends StatelessWidget {
  const OwnerServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              OwnerGetServicesCubit(ServiceLocator.sl())..getServices(),
        ),
        BlocProvider(
          create: (_) => OwnerUpdateServicesCubit(ServiceLocator.sl()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<OwnerGetServicesCubit, OwnerGetServicesState>(
            listener: (context, state) {
              if (state is OwnerGetServicesSuccess) {
                context.read<OwnerUpdateServicesCubit>().initServices(
                  state.serviceModel,
                );
              } else if (state is OwnerGetServicesFailure &&
                  state.serviceModel.isNotEmpty) {
                AppSnackbar.error(
                  context,
                  message: 'تعذر تحديث قائمة الخدمات: ${state.failureMessage}',
                );
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.appBackground,
              body: const SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.lg,
                          AppSpacing.md,
                          AppSpacing.md,
                        ),
                        child: AppText.title(
                          'إدارة الخدمات',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    OwnerServicesSection(),
                  ],
                ),
              ),
              bottomSheet: AppBottomSheetBtn(
                title: 'حفظ التعديلات',
                onPressed: context.read<OwnerUpdateServicesCubit>().saveChanges,
              ),
            );
          },
        ),
      ),
    );
  }
}
