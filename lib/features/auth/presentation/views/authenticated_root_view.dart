import 'package:digital_product/features/auth/domain/enums/user_role.dart';

import 'package:flutter/material.dart';

class AuthenticatedRootView extends StatelessWidget {
  const AuthenticatedRootView({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('نوع الحساب غير مدعوم.')));
  }
}
