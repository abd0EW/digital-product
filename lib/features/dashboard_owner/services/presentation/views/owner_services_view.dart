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
          create: (_) => OwnerUpdateServicesCubit(ServiceLocator.sl()),
        ),

        BlocProvider(
          create: (_) =>
              OwnerGetServicesCubit(ServiceLocator.sl())..getServices(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<OwnerGetServicesCubit, OwnerGetServicesState>(
            listener: (context, state) {
              if (state is OwnerGetServicesSuccess) {
                context
                    .read<OwnerUpdateServicesCubit>()
                    .initializeOriginalStatuses(state.serviceModel);
              } else if (state is OwnerGetServicesFailure &&
                  state.serviceModel.isNotEmpty) {
                AppSnackbar.error(
                  context,
                  message: 'تعذر تحديث قائمة الخدمات: ${state.failureMessage}',
                );
              }
            },
          ),

          BlocListener<OwnerUpdateServicesCubit, OwnerUpdateServicesState>(
            listener: (context, state) {
              if (state is OwnerUpdateServicesSuccess) {
                AppSnackbar.success(context, message: 'تم حفظ التعديلات بنجاح');
                if (state.successfullySavedServiceIds.isNotEmpty) {
                  context.read<OwnerGetServicesCubit>().getServices();
                }
              } else if (state is OwnerUpdateServicesFailure) {
                AppSnackbar.error(context, message: state.failureMessage);
                if (state.successfullySavedServiceIds.isNotEmpty) {
                  context.read<OwnerGetServicesCubit>().getServices();
                }
              }
            },
          ),
        ],
        child: Scaffold(
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
          bottomSheet:
              BlocSelector<
                OwnerUpdateServicesCubit,
                OwnerUpdateServicesState,
                ({bool hasPendingChanges, bool isSaving})
              >(
                selector: (state) => (
                  hasPendingChanges: state.changedServices.isNotEmpty,
                  isSaving: state is OwnerUpdateServicesSaving,
                ),
                builder: (context, buttonState) {
                  if (!buttonState.hasPendingChanges) {
                    return const SizedBox.shrink();
                  }

                  return AppBottomSheetBtn(
                    title: 'حفظ التعديلات',
                    isLoading: buttonState.isSaving,
                    disabled: buttonState.isSaving,
                    onPressed: context
                        .read<OwnerUpdateServicesCubit>()
                        .saveChanges,
                  );
                },
              ),
        ),
      ),
    );
  }
}
