import 'package:digital_product/core/utils/file_url_resolver/file_url_resolver.dart';
import 'package:digital_product/core/utils/mime_type/mime_type_resolver.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/remote_data_source/orders_files/order_files_remote_data_source.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderFilesRemoteDataSourceImpl implements OrderFilesRemoteDataSource {
  final SupabaseClient _client;
  final MimeTypeResolver _mimeTypeResolver;
  final FileUrlResolver _fileUrlResolver;
  OrderFilesRemoteDataSourceImpl({
    SupabaseClient? client,
    required this._fileUrlResolver,
    required this._mimeTypeResolver,
  }) : _client = client ?? Supabase.instance.client;

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
            contentType: _mimeTypeResolver.getMimeType(extension),
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

  @override
  Future<String> getOrderFileUrl({required String storagePath}) async {
    return _fileUrlResolver.getFileUrl(
      bucketName: "user-files",
      storagePath: storagePath,
    );
  }
}
