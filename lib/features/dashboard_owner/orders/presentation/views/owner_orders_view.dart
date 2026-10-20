import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/file_url_resolver/file_url_resolver_impl.dart';
import 'package:digital_product/core/utils/mime_type/mime_type_resolver_impl.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_order_filters.dart';
import 'package:digital_product/features/dashboard_owner/orders/presentation/widgets/owner_orders_table.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/get_orders/get_order_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders_files/order_files_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/repositories_impl/get_order_repository_impl/get_order_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_orders_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerOrdersView extends StatelessWidget {
  const OwnerOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetOrderCubit(
        getOrdersUsecase: GetOrdersUsecase(
          GetOrderRepositoryImpl(
            remoteDataSource: GetOrderRemoteDataSourceImpl(),
            orderFilesRemoteDataSource: OrderFilesRemoteDataSourceImpl(
              fileUrlResolver: FileUrlResolverImpl(),
              mimeTypeResolver: MimeTypeResolverImpl(),
            ),
          ),
        ),
      )..getOwnerOrders(),
      child: const Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: AppText.title('الطلبات'),
                ),
              ),
              OwnerOrderFilters(),
              SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
              OwnerOrdersTable(),
            ],
          ),
        ),
      ),
    );
  }
}
