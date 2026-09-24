import 'package:file_picker/file_picker.dart';
import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_bottom_sheet_btn.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/widgets/order_summary_card.dart';
import 'package:digital_product/features/dashboard_worker/orders/data/models/worker_order_model.dart';
import 'package:digital_product/features/dashboard_worker/orders/presentation/widgets/worker_order_status_badge.dart';
import 'package:flutter/material.dart';

class WorkerOrderDetailsView extends StatefulWidget {
  const WorkerOrderDetailsView({required this.order, super.key});

  final WorkerOrderModel order;

  @override
  State<WorkerOrderDetailsView> createState() => _WorkerOrderDetailsViewState();
}

class _WorkerOrderDetailsViewState extends State<WorkerOrderDetailsView> {
  late WorkerOrderStatus _status;
  late WorkerPaymentStatus _paymentStatus;
  String? _finalFileName;

  @override
  void initState() {
    super.initState();
    _status = widget.order.status;
    _paymentStatus = widget.order.paymentStatus;
  }

  Future<void> _uploadFinalFile() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );
    if (file == null || !mounted) return;
    setState(() {
      _finalFileName = file.name;
      _status = WorkerOrderStatus.completed;
    });
  }

  void _requestPayment() {
    setState(() => _status = WorkerOrderStatus.awaitingPayment);
  }

  String? get _actionTitle {
    if (_status == WorkerOrderStatus.completed) return null;
    if (_status == WorkerOrderStatus.awaitingPayment) {
      return 'بانتظار دفع العميل';
    }
    if (widget.order.paymentType == WorkerPaymentType.afterWork &&
        _paymentStatus == WorkerPaymentStatus.unpaid) {
      return 'طلب الدفع';
    }
    return 'رفع الملف النهائي';
  }

  VoidCallback? get _action {
    if (_status == WorkerOrderStatus.completed ||
        _status == WorkerOrderStatus.awaitingPayment) {
      return null;
    }
    if (widget.order.paymentType == WorkerPaymentType.afterWork &&
        _paymentStatus == WorkerPaymentStatus.unpaid) {
      return _requestPayment;
    }
    return _uploadFinalFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            toolbarHeight: 50,
            title: const AppText.title('تفاصيل الطلب'),
            backgroundColor: AppColors.appBackground,
            surfaceTintColor: AppColors.appBackground,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              110,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                DetailsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText.title(
                              widget.order.serviceName,
                              maxLines: 1,
                            ),
                          ),
                          WorkerOrderStatusBadge(status: _status),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      AppText.body('العميل: ${widget.order.customerName}'),
                      const SizedBox(height: 4),
                      AppText.body(widget.order.description),
                      const SizedBox(height: AppSpacing.sm),
                      AppText.caption(
                        '${widget.order.orderNumber}  •  ${widget.order.quantity}',
                      ),
                      if (widget.order.deadline != null) ...[
                        const SizedBox(height: 4),
                        AppText.body('موعد التسليم: ${widget.order.deadline}'),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                DetailsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AppText.title('الملفات المرفقة'),
                      const SizedBox(height: AppSpacing.sm),
                      AppText.body(
                        widget.order.attachmentName ?? 'لا توجد ملفات مرفقة',
                      ),
                      if (widget.order.attachmentSize != null)
                        AppText.caption(widget.order.attachmentSize!),
                      if (_finalFileName != null) ...[
                        const SizedBox(height: AppSpacing.sm),
                        AppText.body(
                          'الملف النهائي: $_finalFileName',
                          color: AppColors.success,
                        ),
                      ],
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomSheet: _actionTitle == null
          ? null
          : AppBottomSheetBtn(
              title: _actionTitle!,
              color: _action == null
                  ? AppColors.bodyText
                  : AppColors.secondaryButtonBackground,
              onPressed: _action,
              disabled: _action == null,
            ),
    );
  }
}
