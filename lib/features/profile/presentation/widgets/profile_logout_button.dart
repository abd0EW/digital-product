import 'package:digital_product/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      title: 'تسجيل الخروج',
      onPressed: () {},
      width: double.infinity,
      height: 50,
      backgroundColor: const Color(0xFFFFF0F0),
      foregroundColor: const Color(0xFFD64545),
      borderColor: const Color(0xFFF2CACA),
      icon: const Icon(Icons.logout_rounded),
    );
  }
}
