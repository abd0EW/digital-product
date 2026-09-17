import 'package:flutter/material.dart';

class AppCloseIcon extends StatelessWidget {
  const AppCloseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(244, 244, 245, 1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          size: 17,
          color: Color.fromRGBO(151, 172, 202, 1),
        ),
      ),
    );
  }
}
