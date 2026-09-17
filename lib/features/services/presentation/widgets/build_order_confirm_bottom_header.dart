import 'package:digital_product/core/widgets/app_close_icon.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/services/data/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BuildOrderConfirmBottomHeader extends StatelessWidget {
  const BuildOrderConfirmBottomHeader({super.key, required this.serviceModel});
  final ServiceModel serviceModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.caption("المبلغ المطلوب"),
              Row(
                children: [
                  AppText.title(serviceModel.price),
                  const Gap(4),
                  const AppText.caption("ر.س"),
                ],
              ),
              AppText.caption(serviceModel.description),
            ],
          ),
        ),
        SizedBox(width: 20),
        AppCloseIcon(),
      ],
    );
  }
}
