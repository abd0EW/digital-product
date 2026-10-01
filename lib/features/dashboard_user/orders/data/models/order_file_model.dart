class OrderFileModel {
  final String? id;
  final String orderId;
  final String uploadedBy;
  final String fileType;
  final String fileName;
  final String storagePath;
  final String? mimeType;
  final int? fileSize;
  final String? bucketName;
  final DateTime? createdAt;

  const OrderFileModel({
    this.id,
    required this.orderId,
    required this.uploadedBy,
    required this.fileType,
    required this.fileName,
    required this.storagePath,
    this.mimeType,
    this.fileSize,
    this.bucketName,
    this.createdAt,
  });

  factory OrderFileModel.fromJson(Map<String, dynamic> json) {
    return OrderFileModel(
      id: json['id'] as String?,
      orderId: json['order_id'] as String,
      uploadedBy: json['uploaded_by'] as String,
      fileType: json['file_type'] as String,
      fileName: json['file_name'] as String,
      storagePath: json['storage_path'] as String,
      mimeType: json['mime_type'] as String?,
      fileSize: json['file_size'] != null
          ? (json['file_size'] as num).toInt()
          : null,
      bucketName: json['bucket_name'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'order_id': orderId,
      'uploaded_by': uploadedBy,
      'file_type': fileType,
      'file_name': fileName,
      'storage_path': storagePath,
      'mime_type': mimeType,
      'file_size': fileSize,
      'bucket_name': bucketName,
    };
  }
}
