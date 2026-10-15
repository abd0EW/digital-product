import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';

enum NotificationKind { orderCreated, orderCompleted, general, unknown }

class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    this.order,
    this.orderId,
    this.sentAt,
    this.createdAt,
  });

  final String id;
  final String userId;
  final String? orderId;
  final String type;
  final String title;
  final String body;
  final OrderModel? order;
  final bool isRead;
  final DateTime? sentAt;
  final DateTime? createdAt;

  NotificationKind get kind => switch (type) {
    'order_created' => NotificationKind.orderCreated,
    'order_completed' => NotificationKind.orderCompleted,
    'general' => NotificationKind.general,
    _ => NotificationKind.unknown,
  };

  DateTime? get sortDate => createdAt ?? sentAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      order: json["order"] != null ? OrderModel.fromJson(json["order"]) : null,
      id: json['id'] as String,
      userId: json['user_id'] as String,
      orderId: json['order_id'] as String?,
      type: json['type'] as String? ?? 'unknown',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      isRead: json['is_read'] == true,
      sentAt: _parseDate(json['sent_at']),
      createdAt: _parseDate(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_id': orderId,
      'type': type,
      'title': title,
      'body': body,
      'is_read': isRead,
      'sent_at': sentAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  static DateTime? _parseDate(Object? value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
