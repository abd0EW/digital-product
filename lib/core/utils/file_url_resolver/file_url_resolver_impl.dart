import 'package:supabase_flutter/supabase_flutter.dart';
import 'file_url_resolver.dart';

class FileUrlResolverImpl implements FileUrlResolver {
  final SupabaseClient _client;

  FileUrlResolverImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  @override
  String getFileUrl({required String bucketName, required String storagePath}) {
    return _client.storage.from(bucketName).getPublicUrl(storagePath);
  }
}
