import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/features/dashboard_owner/orders/data/models/owner_order_model.dart';
import 'package:digital_product/features/dashboard_owner/team/data/models/team_member_model.dart';
import 'package:digital_product/features/dashboard_owner/team/presentation/widgets/team_member_card.dart';
import 'package:flutter/material.dart';

class AssignWorkerBottomSheet extends StatefulWidget {
  const AssignWorkerBottomSheet({
    required this.order,
    required this.workers,
    required this.onConfirmed,
    super.key,
  });

  final OwnerOrderModel order;
  final List<TeamMemberModel> workers;
  final ValueChanged<TeamMemberModel> onConfirmed;

  @override
  State<AssignWorkerBottomSheet> createState() =>
      _AssignWorkerBottomSheetState();
}

class _AssignWorkerBottomSheetState extends State<AssignWorkerBottomSheet> {
  TeamMemberModel? selectedWorker;

  void _confirm() {
    final worker = selectedWorker;
    if (worker == null) return;
    widget.onConfirmed(worker);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(child: AppText.title('تعيين منفذ للطلب')),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.bodyText,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              _OrderSummary(order: widget.order),
              const SizedBox(height: AppSpacing.md),
              const AppText.switches('اختر المنفذ'),
              const SizedBox(height: AppSpacing.sm),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.workers.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final worker = widget.workers[index];
                    final isSelected = selectedWorker == worker;
                    return InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                      onTap: () => setState(() => selectedWorker = worker),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.tealPrimary
                                : AppColors.transparent,
                            width: 2,
                          ),
                        ),
                        child: TeamMemberCard(member: worker),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                title: 'تأكيد التعيين',
                onPressed: selectedWorker == null ? null : _confirm,
                backgroundColor: AppColors.tealPrimary,
                foregroundColor: AppColors.whiteText,
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const AppText.body('إلغاء', textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.order});

  final OwnerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.successBackground,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText.body(order.serviceName, color: AppColors.headingText),
          const SizedBox(height: 4),
          AppText.caption(order.orderNumber ?? 'طلب جديد'),
        ],
      ),
    );
  }
}
