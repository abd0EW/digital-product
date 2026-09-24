import 'package:digital_product/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppSilverFailState extends StatelessWidget {
  const AppSilverFailState({super.key, required this.failureMessage});
  final String failureMessage;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(child: AppText.title(failureMessage)),
    );
  }
}
