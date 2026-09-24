import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ServiceCardContent extends StatelessWidget {
  final String title;
  final String description;

  const ServiceCardContent({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText.title(title),

        const SizedBox(height: 4),

        AppText.caption(description, textAlign: TextAlign.right),
      ],
    );
  }
}
