import 'package:digital_product/core/utils/app_payment_option.dart';
import 'package:digital_product/core/utils/app_payment_options.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/payment_model.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/payment_selector.dart';
import 'package:flutter/material.dart';

class BuildOrderConfirmPaymentSelector extends StatefulWidget {
  const BuildOrderConfirmPaymentSelector({super.key});

  @override
  State<BuildOrderConfirmPaymentSelector> createState() =>
      _BuildOrderConfirmPaymentSelectorState();
}

class _BuildOrderConfirmPaymentSelectorState
    extends State<BuildOrderConfirmPaymentSelector> {
  PaymentMethodType selectedMethod = PaymentMethodType.card;

  final paymetOPtion = appPaymentoptions;

  AppPaymentConfig get selectedOption => paymetOPtion.firstWhere(
    (element) => selectedMethod == element.paymentMethodModel.type,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final option in paymetOPtion)
          PaymentSelector(
            paymentMethodModel: option.paymentMethodModel,
            isSelected: selectedMethod == option.paymentMethodModel.type,
            onTap: () {
              if (selectedMethod == option.paymentMethodModel.type) return;

              setState(() {
                selectedMethod = option.paymentMethodModel.type;
              });
            },
          ),

        selectedOption.widgetBuilder(context),
      ],
    );
  }
}
