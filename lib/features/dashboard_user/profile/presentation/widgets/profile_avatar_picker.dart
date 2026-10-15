import 'dart:typed_data';

import 'package:digital_product/core/constants/app_colors.dart';
import 'package:digital_product/core/constants/app_radius.dart';
import 'package:digital_product/core/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatarPicker extends StatefulWidget {
  const ProfileAvatarPicker({
    this.avatarBytes,
    this.avatarUrl,
    this.onAvatarChanged,
    this.readOnly = false,
    this.onTapWhenReadOnly,
    this.enabled = true,
    super.key,
  });

  final Uint8List? avatarBytes;
  final String? avatarUrl;
  final void Function({
    required Uint8List bytes,
    required String extension,
    required String contentType,
  })? onAvatarChanged;
  final bool readOnly;
  final VoidCallback? onTapWhenReadOnly;
  final bool enabled;

  @override
  State<ProfileAvatarPicker> createState() => _ProfileAvatarPickerState();
}

class _ProfileAvatarPickerState extends State<ProfileAvatarPicker> {
  final ImagePicker _picker = ImagePicker();
  bool _isPicking = false;

  Future<void> _pickAvatar() async {
    if (!widget.enabled) return;
    if (widget.readOnly) {
      widget.onTapWhenReadOnly?.call();
      return;
    }
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
      final imageType = _resolveImageType(file);
      if (mounted) {
        widget.onAvatarChanged?.call(
          bytes: bytes,
          extension: imageType.extension,
          contentType: imageType.contentType,
        );
      }
    } on Exception catch (exception) {
      if (mounted) {
        AppSnackbar.error(context, message: 'تعذر اختيار الصورة: $exception');
      }
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  ({String extension, String contentType}) _resolveImageType(XFile file) {
    final suppliedMimeType = file.mimeType?.toLowerCase().split(';').first;
    final suppliedExtension = file.name.contains('.')
        ? file.name.split('.').last.toLowerCase()
        : null;
    final extensionMimeType = switch (suppliedExtension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => null,
    };
    final mimeExtension = switch (suppliedMimeType) {
      'image/jpeg' => 'jpg',
      'image/jpg' => 'jpg',
      'image/png' => 'png',
      'image/webp' => 'webp',
      null || '' => null,
      _ => throw const FormatException('نوع الصورة غير مدعوم'),
    };

    final contentType = suppliedMimeType == 'image/jpg'
        ? 'image/jpeg'
        : suppliedMimeType?.isNotEmpty == true
        ? suppliedMimeType!
        : extensionMimeType;
    final extension = extensionMimeType == null
        ? mimeExtension
        : suppliedExtension;

    if (contentType == null ||
        extension == null ||
        (extensionMimeType != null &&
            suppliedMimeType != null &&
            extensionMimeType != suppliedMimeType)) {
      throw const FormatException('يُسمح فقط بصور JPG أو PNG أو WEBP');
    }

    return (extension: extension, contentType: contentType);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'تغيير الصورة الشخصية',
      child: GestureDetector(
        onTap: !widget.enabled ||
                (widget.readOnly && widget.onTapWhenReadOnly == null)
            ? null
            : _pickAvatar,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.navyPrimary,
              child: ClipOval(
                child: SizedBox(
                  width: 84,
                  height: 84,
                  child: _buildAvatarImage(),
                ),
              ),
            ),
            Positioned(
              bottom: -2,
              left: -2,
              width: 30,
              height: 30,
              child: Container(
                padding: const EdgeInsets.all(5),
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

  Widget _buildAvatarImage() {
    final bytes = widget.avatarBytes;
    if (bytes != null) {
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _defaultAvatar(),
      );
    }

    final imageUrl = widget.avatarUrl;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        key: ValueKey(imageUrl),
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _defaultAvatar(),
      );
    }

    return _defaultAvatar();
  }

  Widget _defaultAvatar() {
    return const ColoredBox(
      color: AppColors.navyPrimary,
      child: Center(
        child: Icon(
          Icons.person_rounded,
          color: AppColors.appBackground,
          size: 44,
        ),
      ),
    );
  }
}
