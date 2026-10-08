import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_container.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/order_state.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/submit_order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/submit_order_state.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/create_order_step_content.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateOrderBottomSheet extends StatefulWidget {
  const CreateOrderBottomSheet({super.key, required this.service});

  final ServiceModel service;

  @override
  State<CreateOrderBottomSheet> createState() => _CreateOrderBottomSheetState();
}

class _CreateOrderBottomSheetState extends State<CreateOrderBottomSheet> {
  final TextEditingController _notesController = TextEditingController();

  Future<void> _pickFile() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'doc', 'docx', 'pdf'],
      );

      if (file == null) return;
      if (!mounted) return;

      context.read<CreateOrderCubit>().selectFile(file);
    } catch (error, stackTrace) {
      debugPrint('File picker error: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر اختيار الملف، حاول مرة أخرى.')),
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubmitOrderCubit, SubmitOrderState>(
      listener: (context, state) {
        if (state is SubmitOrderSuccess) {
          context.read<CreateOrderCubit>().showConfirmation();
          AppSnackbar.success(context, message: 'تم إنشاء الطلب بنجاح.');
        }
      },

      builder: (context, state) {
        final submitCubit = context.read<SubmitOrderCubit>();

        return BlocBuilder<CreateOrderCubit, CreateOrderState>(
          builder: (context, formState) {
            final formCubit = context.read<CreateOrderCubit>();

            return AppBottomSheetContainer(
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: CreateOrderStepContent(
                      pageCount: formState.quantity,
                      currentStep: formState.step,
                      isSubmitting: submitCubit.isSubmitting,
                      isSelectedFile: formCubit.showFileError,
                      service: widget.service,
                      notesController: _notesController,
                      fileName: formCubit.selectedFile?.name,
                      isUploaded: formCubit.selectedFile != null,
                      onUploadFile: _pickFile,
                      onReview: formCubit.showReview,
                      onEdit: formCubit.editOrder,
                      onConfirm: () {
                        final userId =
                            Supabase.instance.client.auth.currentUser?.id;

                        if (userId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يرجى تسجيل الدخول أولًا.'),
                            ),
                          );

                          return;
                        }

                        if (!formCubit.validateSelectedFile()) return;

                        final unitPrice = widget.service.price;

                        final subtotal = formCubit.calculateSubtotal(unitPrice);

                        final totalAmount = formCubit.calculateTotal(
                          price: unitPrice,
                        );

                        final notes = _notesController.text.trim();

                        final order = OrderModel(
                          userId: userId,
                          service: widget.service,
                          serviceId: widget.service.id,
                          quantity: formCubit.quantity,
                          unitPrice: unitPrice,
                          subtotal: subtotal,
                          totalAmount: totalAmount,
                          paymentTiming: widget.service.paymentTiming,
                          paymentStatus: 'pending',
                          status: 'pending',
                          notes: notes.isEmpty ? null : notes,
                        );
                        submitCubit.createOrder(
                          order: order,
                          file: formCubit.selectedFile,
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
