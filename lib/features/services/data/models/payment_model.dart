import 'package:flutter/material.dart';

enum PaymentMethodType { card, applePay, stcPay }

class PaymentMethodModel {
  final String title;
  final IconData icon;
  final PaymentMethodType type;

  const PaymentMethodModel({
    required this.title,
    required this.icon,
    required this.type,
  });
}
