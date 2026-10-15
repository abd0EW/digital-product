import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';

class OrderModel {
  final String? id;
  final int? orderNumber;

  final String? userId;
  final String serviceId;
  final String? workerId;

  final int quantity;
  final double unitPrice;
  final double subtotal;

  final double totalAmount;

  final String paymentTiming;
  final String paymentStatus;
  final String status;

  final String? notes;

  final DateTime? assignedAt;
  final DateTime? startedAt;
  final DateTime? paymentRequestedAt;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final ServiceModel? service;
  const OrderModel({
    this.id,
    this.orderNumber,
    this.userId,
    required this.serviceId,
    this.workerId,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.service,
    required this.totalAmount,
    required this.paymentTiming,
    required this.paymentStatus,
    required this.status,
    this.notes,
    this.assignedAt,
    this.startedAt,
    this.paymentRequestedAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      service: json["service"] != null
          ? ServiceModel.fromJson(Map<String, dynamic>.from(json["service"]))
          : null,
      id: json['id'] as String?,
      orderNumber: json['order_number'] != null
          ? (json['order_number'] as num).toInt()
          : null,
      userId: json['user_id'] as String?,
      serviceId: json['service_id'] as String,
      workerId: json['worker_id'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),

      totalAmount: (json['total_amount'] as num).toDouble(),
      paymentTiming: json['payment_timing'] as String,
      paymentStatus: json['payment_status'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      assignedAt: json['assigned_at'] != null
          ? DateTime.parse(json['assigned_at'])
          : null,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : null,
      paymentRequestedAt: json['payment_requested_at'] != null
          ? DateTime.parse(json['payment_requested_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'user_id': userId,
      'service_id': serviceId,
      'quantity': quantity,
      'unit_price': unitPrice,
      'subtotal': subtotal,

      'total_amount': totalAmount,
      'payment_timing': paymentTiming,
      'payment_status': paymentStatus,
      'status': status,
      'notes': notes,
    };
  }
}
