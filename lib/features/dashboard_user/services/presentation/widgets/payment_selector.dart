import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/payment_model.dart';
import 'package:flutter/material.dart';

class PaymentSelector extends StatelessWidget {
  const PaymentSelector({
    super.key,
    required this.paymentMethodModel,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentMethodModel paymentMethodModel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryButtonBackground.withOpacity(0.08)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.secondaryIcon
                : AppColors.cardBackground,
          ),
        ),
        child: Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
              activeColor: AppColors.secondaryButtonBackground,
            ),

            const SizedBox(width: 8),

            Icon(
              paymentMethodModel.icon,
              size: 20,
              color: AppColors.primaryIcon,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                paymentMethodModel.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
