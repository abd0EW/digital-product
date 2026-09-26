import 'package:digital_product/core/utils/app_validators.dart';
import 'package:digital_product/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      suffixIcon: IconButton(
        onPressed: _togglePasswordVisibility,
        icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
      ),
      hintText: 'كلمة المرور',
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      validator: AppValidators.password,
      obscureText: _isObscure,
    );
  }
}
