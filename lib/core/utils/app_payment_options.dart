import 'package:digital_product/core/utils/app_payment_option.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/payment_card_selector.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/payment_model.dart';
import 'package:flutter/material.dart';

List<AppPaymentConfig> appPaymentoptions = List.unmodifiable([
  AppPaymentConfig(
    paymentMethodModel: const PaymentMethodModel(
      title: "Card",
      icon: Icons.credit_card,
      type: PaymentMethodType.card,
    ),
    widgetBuilder: (context) => const CardPaymentFields(),
  ),

  AppPaymentConfig(
    paymentMethodModel: const PaymentMethodModel(
      title: 'Apple Pay',
      icon: Icons.apple,
      type: PaymentMethodType.applePay,
    ),
    widgetBuilder: (context) => const SizedBox.shrink(),
  ),
]);
