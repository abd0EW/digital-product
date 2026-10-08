import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders/get_order_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders_files/order_files_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/repositories_impl/create_order_repository_impl.dart/create_orders_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/repositories_impl/get_order_repository_impl/get_order_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/create_order_repository/create_orders_repository.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/get_order_repository/get_order_repository.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/create_order_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_orders_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/save_order_file_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/submit_order_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/upload_order_file_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/submit_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_cubit.dart';
import 'package:digital_product/features/dashboard_user/services/data/remote_data_source/services_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/services/data/repositories/services_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/view_model/services/services_cubit.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  ServiceLocator._();

  static final GetIt sl = GetIt.instance;

  static Future<void> registerDependencies() async {
    // =========================================================
    // SERVICES
    // =========================================================

    sl.registerLazySingleton<ServicesRemoteDataSourceImpl>(
      () => ServicesRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<ServicesRepositoryImpl>(
      () => ServicesRepositoryImpl(sl<ServicesRemoteDataSourceImpl>()),
    );

    sl.registerFactory<ServicesCubit>(
      () => ServicesCubit(sl<ServicesRepositoryImpl>()),
    );

    // =========================================================
    // ORDERS DATA SOURCES
    // =========================================================

    sl.registerLazySingleton<GetOrderRemoteDataSourceImpl>(
      () => GetOrderRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<OrderFilesRemoteDataSourceImpl>(
      () => OrderFilesRemoteDataSourceImpl(),
    );

    // =========================================================
    // ORDERS REPOSITORY
    // =========================================================

    sl.registerLazySingleton<CreateOrdersRepository>(
      () => CreateOrdersRepositoryImpl(
        remoteDataSource: sl<GetOrderRemoteDataSourceImpl>(),
        orderFilesRemoteDataSourceImpl: sl<OrderFilesRemoteDataSourceImpl>(),
      ),
    );

    sl.registerLazySingleton<GetOrderRepository>(
      () => GetOrderRepositoryImpl(
        remoteDataSource: sl<GetOrderRemoteDataSourceImpl>(),
      ),
    );

    // =========================================================
    // ORDERS USE CASES
    // =========================================================

    sl.registerLazySingleton<CreateOrderUseCase>(
      () => CreateOrderUseCase(sl<CreateOrdersRepository>()),
    );

    sl.registerLazySingleton<UploadOrderFileUseCase>(
      () => UploadOrderFileUseCase(sl<CreateOrdersRepository>()),
    );

    sl.registerLazySingleton<SaveOrderFileUseCase>(
      () => SaveOrderFileUseCase(sl<CreateOrdersRepository>()),
    );

    sl.registerLazySingleton<SubmitOrderUseCase>(
      () => SubmitOrderUseCase(
        createOrderUseCase: sl<CreateOrderUseCase>(),
        uploadOrderFileUseCase: sl<UploadOrderFileUseCase>(),
        saveOrderFileUseCase: sl<SaveOrderFileUseCase>(),
      ),
    );

    sl.registerLazySingleton<GetOrdersUsecase>(
      () => GetOrdersUsecase(sl<GetOrderRepository>()),
    );

    // =========================================================
    // ORDER CUBITS
    // =========================================================

    sl.registerFactory<CreateOrderCubit>(() => CreateOrderCubit());

    sl.registerFactory<SubmitOrderCubit>(
      () => SubmitOrderCubit(submitOrderUseCase: sl<SubmitOrderUseCase>()),
    );

    sl.registerFactory<GetOrderFilesCubit>(
      () => GetOrderFilesCubit(getOrdersUsecase: sl<GetOrdersUsecase>()),
    );
  }
}
