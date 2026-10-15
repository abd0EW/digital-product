import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_spacing.dart';
import 'package:digital_product/core/utils/app_validators.dart';
import 'package:digital_product/core/widgets/app_button.dart';
import 'package:digital_product/core/widgets/app_text.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.onSave,
    required this.onCancel,
    this.isSaving = false,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final bool isSaving;

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppText.title('تعديل البيانات'),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: widget.nameController,
            label: 'الاسم الكامل',
            hintText: 'أدخل اسمك الكامل',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) =>
                AppValidators.requiredField(value, fieldName: 'الاسم الكامل'),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: widget.phoneController,
            label: 'رقم الجوال',
            hintText: '05XXXXXXXX',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: widget.emailController,
            label: 'البريد الإلكتروني',
            hintText: 'أدخل بريدك الإلكتروني',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: AppValidators.email,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: AppButton(
                    title: 'حفظ التغييرات',
                    onPressed: widget.isSaving ? null : _submit,
                    isLoading: widget.isSaving,
                    backgroundColor: AppColors.navyPrimary,
                    foregroundColor: AppColors.whiteText,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: AppButton(
                    title: 'إلغاء',
                    onPressed: widget.isSaving ? null : widget.onCancel,
                    backgroundColor: AppColors.secondaryButtonBackground,
                    foregroundColor: AppColors.appBackground,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
