import 'dart:async';
import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/widgets/app_search_silver_appbar.dart';
import 'package:digital_product/core/widgets/app_show_model_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:digital_product/features/dashboard_user/services/data/remote_data_source/services_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/services/data/repositories/services_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/view_model/services/services_cubit.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/service_order_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/services_silver_body.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/services_silver_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onServicePressed(ServiceModel service) {
    AppShowModelBottomSheet.appShowModalBottomSheet(
      context,

      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: ServiceOrderBottomSheet(service: service),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: BlocProvider(
        create: (context) => ServicesCubit(
          ServicesRepositoryImpl(ServicesRemoteDataSourceImpl()),
        )..getServices(),
        child: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  AppSearchSilverAppbar(
                    onChanged: (value) => context
                        .read<ServicesCubit>()
                        .onSearchChanged(searchController.text),
                    searchController: searchController,
                    textHedader: "الخدمات المتاحه",
                  ),

                  ServicesSilverToggle(),

                  ServicesSliverBody(onServicePressed: onServicePressed),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
