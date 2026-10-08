import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';

sealed class GetOrderFilesState {
  const GetOrderFilesState();
}

final class GetOrderFilesInitial extends GetOrderFilesState {
  const GetOrderFilesInitial();
}

final class GetOrderFilesLoading extends GetOrderFilesState {
  const GetOrderFilesLoading();
}

final class GetOrderFilesSuccess extends GetOrderFilesState {
  final List<OrderFileModel> files;

  const GetOrderFilesSuccess(this.files);
}

final class GetOrderFilesEmpty extends GetOrderFilesState {
  const GetOrderFilesEmpty();
}

final class GetOrderFilesFailure extends GetOrderFilesState {
  final String message;

  const GetOrderFilesFailure(this.message);
}
