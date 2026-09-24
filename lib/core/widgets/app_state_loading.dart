import 'package:flutter/material.dart';

class appLoadingState extends StatelessWidget {
  const appLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
