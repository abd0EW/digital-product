import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/service_card.dart';
import 'package:flutter/material.dart';

class SerivcesSilverSuccessState extends StatelessWidget {
  const SerivcesSilverSuccessState({
    super.key,
    required this.services,
    required this.onServicePressed,
  });

  final List<ServiceModel> services;
  final ValueChanged<ServiceModel> onServicePressed;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      sliver: SliverList.builder(
        addAutomaticKeepAlives: true,
        itemCount: services.length,

        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            service: service,
            onPressed: () => onServicePressed(service),
          );
        },
      ),
    );
  }
}
