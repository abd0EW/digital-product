import 'package:digital_product/features/auth/domain/enums/user_role.dart';
import 'package:digital_product/features/dashboard_owner/root/presentation/views/owner_root_view.dart';
import 'package:digital_product/features/dashboard_worker/root/presentation/views/worker_root_view.dart';
import 'package:digital_product/root.dart';
import 'package:flutter/material.dart';

class RoleNavigationResolver {
  static final Map<UserRole, WidgetBuilder> _routes = {
    UserRole.user: (_) => const UserRootView(),
    UserRole.owner: (_) => const OwnerRootView(),
    UserRole.worker: (_) => const WorkerRootView(),
  };

  static void resolve(BuildContext context, UserRole role) {
    final builder = _routes[role];

    if (builder == null) {
      throw UnsupportedError('Unsupported role: $role');
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => builder(context)),
      (route) => false,
    );
  }
}
