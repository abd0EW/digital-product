import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum WorkerOrderStatus {
  newOrder,
  inProgress,
  awaitingPayment,
  readyToDeliver,
  completed,
}

extension WorkerOrderStatusX on WorkerOrderStatus {
  String get label => switch (this) {
    WorkerOrderStatus.newOrder => 'جديد',
    WorkerOrderStatus.inProgress => 'قيد التنفيذ',
    WorkerOrderStatus.awaitingPayment => 'بانتظار الدفع',
    WorkerOrderStatus.readyToDeliver => 'جاهز للتسليم',
    WorkerOrderStatus.completed => 'مكتمل',
  };

  Color get color => switch (this) {
    WorkerOrderStatus.newOrder => AppColors.tealPrimary,
    WorkerOrderStatus.inProgress => AppColors.warning,
    WorkerOrderStatus.awaitingPayment => AppColors.bodyText,
    WorkerOrderStatus.readyToDeliver => AppColors.tealPrimary,
    WorkerOrderStatus.completed => AppColors.success,
  };

  Color get backgroundColor => switch (this) {
    WorkerOrderStatus.newOrder => AppColors.successBackground,
    WorkerOrderStatus.inProgress => AppColors.warningBackground,
    WorkerOrderStatus.awaitingPayment => const Color(0xFFF1F3F6),
    WorkerOrderStatus.readyToDeliver => AppColors.successBackground,
    WorkerOrderStatus.completed => AppColors.successBackground,
  };
}

enum WorkerPaymentType { beforeDelivery, afterWork }

enum WorkerPaymentStatus { unpaid, paid, refunded }

class WorkerOrderModel {
  const WorkerOrderModel({
    required this.serviceName,
    required this.customerName,
    required this.description,
    required this.orderNumber,
    required this.quantity,
    required this.date,
    required this.status,
    required this.paymentType,
    required this.paymentStatus,
    this.deadline,
    this.attachmentName,
    this.attachmentSize,
  });

  final String serviceName;
  final String customerName;
  final String description;
  final String orderNumber;
  final String quantity;
  final String date;
  final WorkerOrderStatus status;
  final WorkerPaymentType paymentType;
  final WorkerPaymentStatus paymentStatus;
  final String? deadline;
  final String? attachmentName;
  final String? attachmentSize;
}
