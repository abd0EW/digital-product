import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/features/dashboard_owner/payments/data/payment_data.dart';
import 'package:digital_product/features/dashboard_user/services/data/models/service_model.dart';

import 'package:digital_product/features/dashboard_user/services/presentation/widgets/build_order_confirm_bottom_sheet.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/build_order_content.dart';
import 'package:digital_product/features/dashboard_user/services/presentation/widgets/service_order_review_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

enum BottomSheetStep { order, review, confirm }

class ServiceOrderBottomSheet extends StatefulWidget {
  const ServiceOrderBottomSheet({super.key, required this.service});

  final ServiceModel service;

  @override
  State<ServiceOrderBottomSheet> createState() =>
      _ServiceOrderBottomSheetState();
}

class _ServiceOrderBottomSheetState extends State<ServiceOrderBottomSheet> {
  final TextEditingController _notesController = TextEditingController();

  int _pagesCount = 1;

  BottomSheetStep _currentStep = BottomSheetStep.order;

  PlatformFile? _selectedFile;

  void _incrementPages() {
    setState(() {
      _pagesCount++;
    });
  }

  void _decrementPages() {
    if (_pagesCount <= 1) return;

    setState(() {
      _pagesCount--;
    });
  }

  void _showReview() {
    setState(() {
      _currentStep = BottomSheetStep.review;
    });
  }

  void _editOrder() {
    setState(() {
      _currentStep = BottomSheetStep.order;
    });
  }

  void _confirmOrder() {
    setState(() {
      _currentStep = BottomSheetStep.confirm;
    });
  }

  Future<void> _uploadFile() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (file == null) return;
      if (!mounted) return;

      setState(() {
        _selectedFile = file;
      });

      debugPrint('Picked ${file.name} (${await file.length()} bytes)');
    } catch (error) {
      debugPrint('File picker error: $error');
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case BottomSheetStep.order:
        return BuildOrderContent(
          key: const ValueKey('order-content'),
          service: widget.service,
          pagesCount: _pagesCount,
          totalPrice: widget.service.price * _pagesCount,
          notesController: _notesController,
          fileName: _selectedFile?.name,
          isUploaded: _selectedFile != null,
          onIncrement: _incrementPages,
          onDecrement: _decrementPages,
          onUploadFile: _uploadFile,
          onReview: _showReview,
        );

      case BottomSheetStep.review:
        return ServiceOrderReviewContent(
          key: const ValueKey('review-content'),
          service: widget.service,
          pagesCount: _pagesCount,
          totalPrice: widget.service.price * _pagesCount,
          fileName: _selectedFile?.name ?? 'لم يتم رفع ملف',
          onEdit: _editOrder,
          onConfirm: _confirmOrder,
        );

      case BottomSheetStep.confirm:
        return BuildOrderConfirmBottomSheet(
          key: const ValueKey('confirm-content'),
          serviceModel: widget.service,
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
            child: _buildCurrentStep(),
          ),
        ),
      ),
    );
  }
}
