import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class AppShowModelBottomSheet {
  static Future<dynamic> appShowModalBottomSheet(
    BuildContext context,
    Widget builder, {
    ServiceModel? service,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      useSafeArea: true,
      builder: (BuildContext context) {
        return builder;
      },
    );
  }
}
