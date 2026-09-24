import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/view_model/services/services_cubit.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/view_model/services/services_state.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/serivces_silver_success_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesSliverBody extends StatelessWidget {
  final ValueChanged<ServiceModel> onServicePressed;

  const ServicesSliverBody({super.key, required this.onServicePressed});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ServicesCubit, ServicesState, List<ServiceModel>>(
      selector: (state) {
        if (state is! ServicesSuccess) {
          return [];
        }

        return state.toggleIndex == 0
            ? (state.general ?? [])
            : (state.educational ?? []);
      },
      builder: (context, services) {
        return SerivcesSilverSuccessState(
          services: services,
          onServicePressed: onServicePressed,
        );
      },
    );
  }
}
