import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_validators.dart';
import 'package:digital_product/core/widgets/app_animated_child.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class AddAssistantSliver extends StatelessWidget {
  const AddAssistantSliver({
    required this.isVisible,
    required this.nameController,
    required this.emailController,
    required this.onSubmit,
    required this.onCancel,
    super.key,
  });

  final bool isVisible;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: isVisible
            ? Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  bottom: AppSpacing.lg,
                ),
                child: AppAnimatedChild(
                  child: _AddAssistantForm(
                    nameController: nameController,
                    emailController: emailController,
                    onSubmit: onSubmit,
                    onCancel: onCancel,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _AddAssistantForm extends StatefulWidget {
  const _AddAssistantForm({
    required this.nameController,
    required this.emailController,
    required this.onSubmit,
    required this.onCancel,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  State<_AddAssistantForm> createState() => _AddAssistantFormState();
}

class _AddAssistantFormState extends State<_AddAssistantForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) widget.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppText.title('إضافة مساعد جديد'),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: widget.nameController,
              label: 'الاسم الكامل',
              hintText: 'أدخل الاسم الكامل',
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  AppValidators.requiredField(value, fieldName: 'الاسم الكامل'),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppTextField(
              controller: widget.emailController,
              label: 'البريد الإلكتروني',
              hintText: 'أدخل البريد الإلكتروني',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: AppValidators.email,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: AppSpacing.sm,
              children: [
                Expanded(
                  child: AppButton(
                    title: 'إضافة',
                    onPressed: _submit,
                    backgroundColor: AppColors.success,
                    foregroundColor: AppColors.whiteText,
                  ),
                ),

                Expanded(
                  child: AppButton(
                    title: 'إلغاء',
                    onPressed: _submit,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
