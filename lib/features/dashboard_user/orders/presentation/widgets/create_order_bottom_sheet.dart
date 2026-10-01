import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/order_cubit.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/order_state.dart';
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
    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) {
        if (state is CreateOrderFailure) {}

        if (state is CreateOrderSuccess) {
          AppSnackbar.success(context, message: 'تم إنشاء الطلب بنجاح.');
        }
      },

      builder: (context, state) {
        final cubit = context.read<CreateOrderCubit>();
        final isSubmitting = context.read<CreateOrderCubit>().isSubmitting;

        return Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(26),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: CreateOrderStepContent(
                  pageCount: state.quantity,
                  currentStep: state.step,
                  isSubmitting: isSubmitting,
                  isSelectedFile: cubit.showFileError,
                  service: widget.service,
                  notesController: _notesController,
                  fileName: cubit.selectedFile?.name,
                  isUploaded: cubit.selectedFile != null,
                  onUploadFile: _pickFile,
                  onReview: cubit.showReview,
                  onEdit: cubit.editOrder,

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

                    final unitPrice = widget.service.price;

                    final subtotal = cubit.calculateSubtotal(unitPrice);

                    final totalAmount = cubit.calculateTotal(price: unitPrice);

                    final notes = _notesController.text.trim();

                    final order = OrderModel(
                      userId: userId,
                      serviceId: widget.service.id,
                      quantity: cubit.quantity,
                      unitPrice: unitPrice,
                      subtotal: subtotal,
                      totalAmount: totalAmount,
                      paymentTiming: widget.service.paymentTiming,
                      paymentStatus: 'pending',
                      status: 'awaiting_payment',
                      notes: notes.isEmpty ? null : notes,
                    );
                    cubit.createOrder(order: order);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
