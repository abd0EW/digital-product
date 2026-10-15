import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class CardPaymentFields extends StatefulWidget {
  const CardPaymentFields({super.key});

  @override
  State<CardPaymentFields> createState() => _CardPaymentFieldsState();
}

class _CardPaymentFieldsState extends State<CardPaymentFields> {
  final cardController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  void dispose() {
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        AppTextField(controller: cardController, hintText: "Card Number"),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: AppTextField(
                controller: expiryController,
                hintText: "MM/YY",
              ),
            ),
            Expanded(
              child: AppTextField(controller: cvvController, hintText: "CVV"),
            ),
          ],
        ),
      ],
    );
  }
}
