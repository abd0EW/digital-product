import 'package:digital_product/core/utils/file_url_resolver/file_url_resolver.dart';
import 'package:digital_product/core/utils/file_url_resolver/file_url_resolver_impl.dart';
import 'package:digital_product/core/utils/mime_type/mime_type_resolver.dart';
import 'package:digital_product/core/utils/mime_type/mime_type_resolver_impl.dart';
import 'package:digital_product/features/dashboard_owner/services/data/datasources/owner_services_remote_data_source.dart';
import 'package:digital_product/features/dashboard_owner/services/domain/usecase/get_services__owner_use_case.dart';
import 'package:digital_product/features/dashboard_user/notifications/data/remote_data_source/notification_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/notifications/presentation/viewmodels/cubit/notification_cubit.dart';

import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/get_orders/get_order_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders_files/order_files_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders_files/order_files_remote_data_source_impl.dart';
// import 'package:digital_product/features/dashboard_owner/orders/data/remote_data_source/owner_orders_remote_data_source.dart';
// import 'package:digital_product/features/dashboard_owner/orders/data/remote_data_source/owner_orders_remote_data_source_impl.dart';
// import 'package:digital_product/features/dashboard_owner/orders/data/repositories/owner_orders_repository_impl.dart';
// import 'package:digital_product/features/dashboard_owner/orders/domain/repositories/owner_orders_repository.dart';
// import 'package:digital_product/features/dashboard_owner/orders/domain/usecases/get_owner_orders_use_case.dart';
// import 'package:digital_product/features/dashboard_owner/orders/presentation/viewmodels/owner_orders_cubit.dart';

import 'package:digital_product/features/dashboard_user/orders/data/repositories_impl/create_order_repository_impl.dart/create_orders_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/orders/data/repositories_impl/get_order_repository_impl/get_order_repository_impl.dart';

import 'package:digital_product/features/dashboard_user/orders/domain/repositories/create_order_repository/create_orders_repository.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/get_order_repository/get_order_repository.dart';

import 'package:digital_product/features/dashboard_user/orders/domain/usecases/create_order_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_file_url_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_orders_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/save_order_file_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/submit_order_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/upload_order_file_use_case.dart';

import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/submit_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_cubit.dart';

import 'package:digital_product/features/dashboard_user/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/notifications/domain/repositories/notifications_repository.dart';
import 'package:digital_product/features/dashboard_user/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:digital_product/features/dashboard_user/services/data/remote_data_source/services_remote_data_source.dart';
import 'package:digital_product/features/dashboard_user/services/data/repositories/services_repository_impl.dart';
import 'package:digital_product/features/dashboard_user/services/domain/repositories/services_repository.dart';
import 'package:digital_product/features/dashboard_user/services/domain/usecases/get_serices_use_case.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/view_model/services/services_cubit.dart';
import 'package:digital_product/features/dashboard_owner/services/data/datasources/owner_services_remote_data_source_impl.dart';
import 'package:digital_product/features/dashboard_owner/services/data/repositories/owner_services_repo_impl.dart';
import 'package:digital_product/features/dashboard_owner/services/domain/repositories/owner_services_repo.dart';
import 'package:digital_product/features/dashboard_owner/services/domain/usecase/update_service_status_use_case.dart';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceLocator {
  ServiceLocator._();

  static final GetIt sl = GetIt.instance;

  static Future<void> registerDependencies() async {
    if (!sl.isRegistered<SupabaseClient>()) {
      sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
    }

    // =========================================================
    // SERVICES
    // =========================================================

    sl.registerLazySingleton<ServicesRemoteDataSourceImpl>(
      () => ServicesRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<ServicesRepositoryImpl>(
      () => ServicesRepositoryImpl(sl<ServicesRemoteDataSourceImpl>()),
    );

    sl.registerLazySingleton<ServicesRepository>(
      () => sl<ServicesRepositoryImpl>(),
    );

    sl.registerLazySingleton<GetServicesUseCase>(
      () => GetServicesUseCase(servicesRepository: sl<ServicesRepository>()),
    );

    sl.registerFactory<ServicesCubit>(
      () => ServicesCubit(sl<GetServicesUseCase>()),
    );

    sl.registerLazySingleton<OwnerServicesRemoteDataSource>(
      () => OwnerServicesRemoteDataSourceImpl(client: sl<SupabaseClient>()),
    );

    sl.registerLazySingleton<OwnerServicesRepo>(
      () => OwnerServicesRepoImpl(sl<OwnerServicesRemoteDataSource>()),
    );

    sl.registerLazySingleton<GetServicesOwnerUseCase>(
      () => GetServicesOwnerUseCase(sl<OwnerServicesRepo>()),
    );

    sl.registerLazySingleton<UpdateServiceStatusUseCase>(
      () => UpdateServiceStatusUseCase(sl<OwnerServicesRepo>()),
    );

    // =========================================================
    // MIME TYPE RESOLVER
    // =========================================================

    sl.registerLazySingleton<MimeTypeResolver>(() => MimeTypeResolverImpl());

    // =========================================================
    // ORDERS DATA SOURCES
    // =========================================================

    sl.registerLazySingleton<GetOrderRemoteDataSourceImpl>(
      () => GetOrderRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<FileUrlResolver>(() => FileUrlResolverImpl());

    sl.registerLazySingleton<OrderFilesRemoteDataSourceImpl>(
      () => OrderFilesRemoteDataSourceImpl(
        fileUrlResolver: sl<FileUrlResolver>(),
        mimeTypeResolver: sl<MimeTypeResolver>(),
      ),
    );

    // نفس الـ Instance لكن عن طريق الـ Abstract Class
    sl.registerLazySingleton<OrderFilesRemoteDataSource>(
      () => sl<OrderFilesRemoteDataSourceImpl>(),
    );

    // =========================================================
    // ORDERS REPOSITORIES
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
        orderFilesRemoteDataSource: sl<OrderFilesRemoteDataSource>(),
      ),
    );

    // =========================================================
    // CREATE ORDER USE CASES
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
        mimeTypeResolver: sl<MimeTypeResolver>(),
        createOrderUseCase: sl<CreateOrderUseCase>(),
        uploadOrderFileUseCase: sl<UploadOrderFileUseCase>(),
        saveOrderFileUseCase: sl<SaveOrderFileUseCase>(),
      ),
    );

    // =========================================================
    // GET ORDER USE CASES
    // =========================================================

    sl.registerLazySingleton<GetOrdersUsecase>(
      () => GetOrdersUsecase(sl<GetOrderRepository>()),
    );

    sl.registerLazySingleton<GetFileUrlUsecase>(
      () => GetFileUrlUsecase(sl<GetOrderRepository>()),
    );

    // =========================================================
    // SERVICES CUBIT REGISTERED ABOVE
    // ORDER CUBITS
    // =========================================================

    sl.registerFactory<CreateOrderCubit>(() => CreateOrderCubit());

    sl.registerFactory<SubmitOrderCubit>(
      () => SubmitOrderCubit(submitOrderUseCase: sl<SubmitOrderUseCase>()),
    );

    sl.registerFactory<GetOrderFilesCubit>(
      () => GetOrderFilesCubit(
        getOrdersUsecase: sl<GetOrdersUsecase>(),
        getFileUrlUsecase: sl<GetFileUrlUsecase>(),
      ),
    );

    // =========================================================
    // NOTIFICATIONS
    // =========================================================

    sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(client: sl<SupabaseClient>()),
    );

    sl.registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepositoryImpl(sl<NotificationRemoteDataSource>()),
    );

    sl.registerLazySingleton<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(sl<NotificationsRepository>()),
    );

    sl.registerFactory<NotificationCubit>(
      () => NotificationCubit(
        getNotificationsUseCase: sl<GetNotificationsUseCase>(),
      ),
    );
  }
}
