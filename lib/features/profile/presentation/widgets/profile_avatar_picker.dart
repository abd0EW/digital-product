import 'dart:typed_data';

import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatarPicker extends StatefulWidget {
  const ProfileAvatarPicker({
    required this.avatarBytes,
    required this.onAvatarChanged,
    super.key,
  });

  final Uint8List? avatarBytes;
  final ValueChanged<Uint8List> onAvatarChanged;

  @override
  State<ProfileAvatarPicker> createState() => _ProfileAvatarPickerState();
}

class _ProfileAvatarPickerState extends State<ProfileAvatarPicker> {
  final ImagePicker _picker = ImagePicker();
  bool _isPicking = false;

  Future<void> _pickAvatar() async {
    if (_isPicking) return;

    setState(() => _isPicking = true);
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 800,
      );
      if (file == null || !mounted) return;

      final bytes = await file.readAsBytes();
      if (mounted) widget.onAvatarChanged(bytes);
    } catch (_) {
      // Picker errors should not interrupt the profile screen.
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'تغيير الصورة الشخصية',
      child: GestureDetector(
        onTap: _pickAvatar,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.navyPrimary,
              backgroundImage: widget.avatarBytes == null
                  ? null
                  : MemoryImage(widget.avatarBytes!),
              child: widget.avatarBytes == null
                  ? const Icon(
                      Icons.person_rounded,
                      color: AppColors.appBackground,
                      size: 44,
                    )
                  : null,
            ),
            Positioned(
              bottom: -2,
              left: -2,
              width: 30,
              height: 30,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.headingText,
                  borderRadius: BorderRadius.circular(AppRadius.small),
                  border: Border.all(color: AppColors.cardBackground, width: 2),
                ),
                child: _isPicking
                    ? const CircularProgressIndicator(
                        color: AppColors.whiteText,
                        strokeWidth: 2,
                        padding: EdgeInsets.all(0),
                      )
                    : const Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.whiteText,
                        size: 15,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
