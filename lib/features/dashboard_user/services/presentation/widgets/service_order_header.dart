import 'package:digital_product/core/widgets/app_close_icon.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceOrderHeader extends StatelessWidget {
  const ServiceOrderHeader({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.title(service.nameAr),
              const SizedBox(height: 2),
              AppText.caption('${service.price} ${service.currency} / صفحة'),
            ],
          ),
        ),

        AppCloseIcon(),
      ],
    );
  }
}
