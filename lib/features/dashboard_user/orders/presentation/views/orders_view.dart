import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/di/service_locator.dart';
import 'package:digital_product/core/utils/file_url_resolver/file_url_resolver_impl.dart';
import 'package:digital_product/core/utils/mime_type/mime_type_resolver_impl.dart';
import 'package:digital_product/core/utils/show_before_payment_bottom_sheet.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_container.dart';
import 'package:digital_product/core/widgets/app_show_model_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/get_orders/get_order_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders_files/order_files_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/repositories_impl/get_order_repository_impl/get_order_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_orders_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/submit_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_state.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/views/order_details_view.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_before_payment_order.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_body_silver.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_silver_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  Future<void> _openOrderDetails(
    BuildContext context,
    OrderModel order,
    String nameOrder,
  ) async {
    if (order.status.trim().toLowerCase() == 'rejected') return;
    FocusManager.instance.primaryFocus?.unfocus();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OrderDetailsView(
          order: order,

          onPayNow: () {
            ShowBeforePaymentBottomSheet.show(
              context: context,
              serviceModel: order.service!,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetOrderCubit(
        getOrdersUsecase: GetOrdersUsecase(
          GetOrderRepositoryImpl(
            orderFilesRemoteDataSource: OrderFilesRemoteDataSourceImpl(
              fileUrlResolver: FileUrlResolverImpl(),
              mimeTypeResolver: MimeTypeResolverImpl(),
            ),
            remoteDataSource: GetOrderRemoteDataSourceImpl(),
          ),
        ),
      )..getOrders(),

      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.appBackground,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    const OrderSilverHeader(),

                    OrderBodySilver(
                      onOrderPressed: (order) {
                        _openOrderDetails(
                          context,
                          order,
                          order.service?.nameAr ?? 'الخدمه',
                        ); // Provide a default name if not available);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
