import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/services/data/models/service_model.dart';
import 'package:digital_product/features/services/presentation/widgets/service_card_actions.dart';
import 'package:digital_product/features/services/presentation/widgets/service_card_content.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel service;
  final VoidCallback onPressed;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onPressed,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.appBackground,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder, width: 1.4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceCardContent(
              title: widget.service.title,
              description: widget.service.description,
            ),

            const SizedBox(height: 12),

            const Divider(height: 1, thickness: 1, color: Color(0xffE3E8EF)),

            const SizedBox(height: 10),

            ServiceCardActions(
              price: widget.service.price,
              currency: widget.service.currency,
              priceDescription: widget.service.priceDescription,
              buttonTitle: 'طلب الخدمة',
              onPressed: widget.onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
