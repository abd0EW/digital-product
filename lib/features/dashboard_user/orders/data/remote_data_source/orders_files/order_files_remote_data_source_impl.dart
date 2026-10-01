import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders_files/order_files_remote_data_source.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderFilesRemoteDataSourceImpl implements OrderFilesRemoteDataSource {
  final SupabaseClient _client;

  OrderFilesRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  @override
  Future<String> uploadOrderFile({
    required PlatformFile file,
    required String userId,
    required String orderId,
  }) async {
    final bytes = await file.readAsBytes();

    final extension = file.extension?.toLowerCase();

    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final fileName = extension != null ? '$timestamp.$extension' : '$timestamp';

    final storagePath = '$userId/$orderId/$fileName';

    await _client.storage
        .from('user-files')
        .uploadBinary(
          storagePath,
          bytes,
          fileOptions: FileOptions(
            upsert: false,
            contentType: _getMimeType(extension),
          ),
        );

    return storagePath;
  }

  @override
  Future<OrderFileModel> saveOrderFile({required OrderFileModel file}) async {
    final response = await _client
        .from('order_files')
        .insert(file.toCreateJson())
        .select()
        .single();

    return OrderFileModel.fromJson(Map<String, dynamic>.from(response));
  }

  String? _getMimeType(String? extension) {
    switch (extension) {
      case 'pdf':
        return 'application/pdf';

      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';

      case 'png':
        return 'image/png';

      case 'doc':
        return 'application/msword';

      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';

      default:
        return null;
    }
  }
}
