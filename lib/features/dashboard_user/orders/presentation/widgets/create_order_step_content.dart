import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/order_state.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_order_confirm_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/build_order_content.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/create_order_review_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderStepContent extends StatelessWidget {
  const CreateOrderStepContent({
    super.key,
    required this.currentStep,
    required this.service,
    required this.notesController,
    required this.fileName,
    required this.isUploaded,
    required this.pageCount,
    required this.onUploadFile,
    required this.onReview,
    required this.onEdit,
    required this.isSelectedFile,
    required this.isSubmitting,
    required this.onConfirm,
  });

  final CreateOrderStep currentStep;

  final ServiceModel service;

  final TextEditingController notesController;

  final String? fileName;

  final bool isSubmitting;

  final int? pageCount;

  final bool isUploaded;
  final bool isSelectedFile;
  final VoidCallback onUploadFile;
  final VoidCallback onReview;
  final VoidCallback onEdit;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateOrderCubit>();

    final quantity = cubit.quantity;

    final totalAmount = cubit.calculateTotal(price: service.price);

    switch (currentStep) {
      case CreateOrderStep.order:
        return BuildOrderContent(
          isSelectedFile: isSelectedFile,
          key: const ValueKey('create-order-content'),
          service: service,
          pagesCount: quantity,
          isSubmitting: isSubmitting,
          totalPrice: totalAmount,
          notesController: notesController,
          fileName: fileName,
          isUploaded: isUploaded,
          onIncrement: cubit.increaseQuantity,
          onDecrement: cubit.decreaseQuantity,
          onUploadFile: onUploadFile,
          onReview: onReview,
        );

      case CreateOrderStep.review:
        return CreateOrderReviewBottomSheet(
          isSubmitting: isSubmitting,
          pageCount: pageCount,
          key: const ValueKey('create-order-review'),
          service: service,
          totalPrice: totalAmount,
          onEdit: onEdit,
          onConfirm: onConfirm,
        );

      case CreateOrderStep.confirm:
        return BuildOrderConfirmBottomSheet(
          key: const ValueKey('create-order-confirm'),
          serviceModel: service,
        );
    }
  }
}
