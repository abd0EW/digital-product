import 'package:digital_product/core/widgets/app_bottom_sheet_container.dart';
import 'package:digital_product/core/widgets/app_show_model_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_before_payment_order.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';

class ShowBeforePaymentBottomSheet {
  static void show({
    required BuildContext context,
    required ServiceModel serviceModel,
  }) {
    AppShowModelBottomSheet.appShowModalBottomSheet(
      context,
      Builder(
        builder: (context) {
          return AppBottomSheetContainer(
            child: BuildBeforePaymentOrder(serviceModel: serviceModel),
          );
        },
      ),
    );
  }
}
