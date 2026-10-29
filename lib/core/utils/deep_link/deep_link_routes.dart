import 'package:digital_product/features/auth/presentation/views/worker_set_password_view.dart';
import 'package:flutter/material.dart';
import 'package:digital_product/core/utils/deep_link/deep_link_type.dart';

class DeepLinkRoutes {
  static Map<String, WidgetBuilder> routes = {
    DeepLinkType.inviteEmailHost.urlHost: (context) =>
        const WorkerSetPasswordView(),
  };
}
