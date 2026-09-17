import 'package:digital_product/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum OrderStatus { inProgress, waitingPayment, completed, rejected }

extension OrderStatusX on OrderStatus {
  String get label => switch (this) {
    OrderStatus.inProgress => 'قيد التنفيذ',
    OrderStatus.waitingPayment => 'بانتظار الدفع',
    OrderStatus.completed => 'مكتمل',
    OrderStatus.rejected => 'مرفوض',
  };

  Color get color => switch (this) {
    OrderStatus.inProgress => AppColors.warning,
    OrderStatus.waitingPayment => AppColors.bodyText,
    OrderStatus.completed => AppColors.success,
    OrderStatus.rejected => AppColors.warning,
  };

  Color get backgroundColor => switch (this) {
    OrderStatus.inProgress => AppColors.warningBackground,
    OrderStatus.waitingPayment => const Color(0xFFF1F3F6),
    OrderStatus.completed => AppColors.successBackground,
    OrderStatus.rejected => const Color(0xFFFFEEEE),
  };
}

class OrderModel {
  const OrderModel({
    required this.serviceName,
    required this.description,
    required this.orderNumber,
    required this.quantity,
    required this.date,
    required this.time,
    required this.status,
    required this.price,
    required this.serviceIcon,
    this.notes,
    this.attachmentName,
    this.attachmentSize,
  });

  final String serviceName;
  final String description;
  final String orderNumber;
  final String quantity;
  final String date;
  final String time;
  final OrderStatus status;
  final String price;
  final IconData serviceIcon;
  final String? notes;
  final String? attachmentName;
  final String? attachmentSize;
}
