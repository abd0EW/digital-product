import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:file_picker/file_picker.dart';

abstract class OrderFilesRemoteDataSource {
  Future<String> uploadOrderFile({
    required PlatformFile file,
    required String userId,
    required String orderId,
  });

  Future<OrderFileModel> saveOrderFile({required OrderFileModel file});
}
