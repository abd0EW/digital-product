import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_fail_state_silver.dart';
import 'package:digital_product/core/widgets/app_state_loading_silver.dart';

import 'package:digital_product/features/dashboard_owner/services/presentation/viewmodels/owner_get_services_cubit/owner_get_services_cubit.dart';
import 'package:digital_product/features/dashboard_owner/services/presentation/widgets/owner_service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerServicesSection extends StatelessWidget {
  const OwnerServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerGetServicesCubit, OwnerGetServicesState>(
      builder: (context, state) {
        if (state is OwnerGetServicesLoading && state.serviceModel.isEmpty) {
          return const AppStateLoadingSilver();
        }

        if (state is OwnerGetServicesFailure && state.serviceModel.isEmpty) {
          return AppFailStateSilver(failureMessage: state.failureMessage);
        }

        final services = switch (state) {
          OwnerGetServicesSuccess(:final serviceModel) => serviceModel,
          OwnerGetServicesLoading(:final serviceModel) => serviceModel,
          OwnerGetServicesFailure(:final serviceModel) => serviceModel,
          _ => const [],
        };

        if (services.isNotEmpty) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverList.builder(
              itemCount: services.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: OwnerServiceCard(service: services[index]),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
