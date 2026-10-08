import 'package:dartz/dartz.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/repositories/get_order_repository/get_order_repository.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_orders_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order_files/get_order_files_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const file = OrderFileModel(
    orderId: 'order-1',
    uploadedBy: 'user-1',
    fileType: 'input',
    fileName: 'document.pdf',
    storagePath: 'orders/document.pdf',
  );

  test('emits loading then success with the retrieved files', () async {
    final cubit = _createCubit((_) async => const Right([file]));
    addTearDown(cubit.close);

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<GetOrderFilesLoading>(),
        isA<GetOrderFilesSuccess>().having((state) => state.files, 'files', [
          file,
        ]),
      ]),
    );

    await cubit.getOrderFiles(orderId: 'order-1');
    await expectation;
  });

  test('emits empty when no files are returned', () async {
    final cubit = _createCubit((_) async => const Right(<OrderFileModel>[]));
    addTearDown(cubit.close);

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([isA<GetOrderFilesLoading>(), isA<GetOrderFilesEmpty>()]),
    );

    await cubit.getOrderFiles(orderId: 'order-1');
    await expectation;
  });

  test('maps domain failures to a user-friendly failure state', () async {
    final cubit = _createCubit(
      (_) async => Left(
        CreateOrderFail(
          message: 'backend details',
          exception: Exception('backend details'),
        ),
      ),
    );
    addTearDown(cubit.close);

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<GetOrderFilesLoading>(),
        isA<GetOrderFilesFailure>().having(
          (state) => state.message,
          'message',
          'تحقق من اتصال الإنترنت وحاول مرة أخرى.',
        ),
      ]),
    );

    await cubit.getOrderFiles(orderId: 'order-1');
    await expectation;
  });

  test('converts unexpected exceptions to a failure state', () async {
    final cubit = _createCubit((_) async => throw Exception('unexpected'));
    addTearDown(cubit.close);

    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<GetOrderFilesLoading>(),
        isA<GetOrderFilesFailure>().having(
          (state) => state.message,
          'message',
          'تعذر تحميل ملفات الطلب. حاول مرة أخرى.',
        ),
      ]),
    );

    await cubit.getOrderFiles(orderId: 'order-1');
    await expectation;
  });
}

GetOrderFilesCubit _createCubit(
  Future<Either<OrderFailure, List<OrderFileModel>>> Function(String orderId)
  getFiles,
) {
  return GetOrderFilesCubit(
    getOrdersUsecase: GetOrdersUsecase(_FakeGetOrderRepository(getFiles)),
  );
}

class _FakeGetOrderRepository implements GetOrderRepository {
  final Future<Either<OrderFailure, List<OrderFileModel>>> Function(String)
  _getFiles;

  const _FakeGetOrderRepository(this._getFiles);

  @override
  Future<Either<OrderFailure, List<OrderModel>>> getUserOrders() async {
    return const Right([]);
  }

  @override
  Future<Either<OrderFailure, List<OrderFileModel>>> getOrderFiles({
    required String orderId,
  }) {
    return _getFiles(orderId);
  }
}
