import 'package:digital_product/features/dashboard_user/services/data/models/payment_model.dart';
import 'package:flutter/material.dart';

class AppPaymentConfig {
  PaymentMethodModel paymentMethodModel;
  WidgetBuilder widgetBuilder;
  AppPaymentConfig({
    required this.paymentMethodModel,
    required this.widgetBuilder,
  });
}
