import 'package:digital_product/core/utils/mime_type/mime_type_resolver.dart';

class MimeTypeResolverImpl implements MimeTypeResolver {
  static const Map<String, String> _mimeTypes = {
    'pdf': 'application/pdf',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'doc': 'application/msword',
    'docx':
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  };

  @override
  String getMimeType(String? extension) =>
      _mimeTypes[extension?.toLowerCase()] ?? 'application/octet-stream';
}
