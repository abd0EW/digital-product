import 'package:digital_product/features/services/data/models/service_model.dart';
import 'package:digital_product/features/services/presentation/widgets/service_card.dart';
import 'package:flutter/material.dart';

class ServicesSliverBody extends StatelessWidget {
  final List<ServiceModel> services;
  final ValueChanged<ServiceModel> onServicePressed;

  const ServicesSliverBody({
    super.key,
    required this.services,
    required this.onServicePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      sliver: SliverList.separated(
        addAutomaticKeepAlives: true,
        itemCount: services.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
        itemBuilder: (context, index) {
          final service = services[index];

          return ServiceCard(
            service: service,
            onPressed: () {
              onServicePressed(service);
            },
          );
        },
      ),
    );
  }
}
