import 'package:digital_product/core/widgets/app_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,

      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        PaymentSelector(
          paymentMethodModel: PaymentMethodModel(
            title: "Card",
            icon: Icons.credit_card,
            type: PaymentMethodType.card,
          ),

          isSelected: selectedMethod == PaymentMethodType.card,
          onTap: () {
            setState(() {
              selectedMethod = PaymentMethodType.card;
            });
          },
        ),

        PaymentSelector(
          paymentMethodModel: PaymentMethodModel(
            title: 'Apple Pay',
            icon: Icons.apple,
            type: PaymentMethodType.applePay,
          ),
          isSelected: selectedMethod == PaymentMethodType.applePay,
          onTap: () {
            setState(() {
              selectedMethod = PaymentMethodType.applePay;
            });
          },
        ),
        if (selectedMethod == PaymentMethodType.card) ...[
          AppTextField(
            controller: TextEditingController(),

            hintText: "Card Number",
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: AppTextField(
                  controller: TextEditingController(),
                  hintText: "MM/YY",
                ),
              ),
              Expanded(
                child: AppTextField(
                  controller: TextEditingController(),
                  hintText: "CVV",
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
