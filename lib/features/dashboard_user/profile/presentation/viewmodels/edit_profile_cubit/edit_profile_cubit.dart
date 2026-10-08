import 'dart:typed_data';

import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:digital_product/features/dashboard_user/profile/domain/usecases/update_profile_usecase.dart';
import 'package:digital_product/features/dashboard_user/profile/presentation/viewmodels/edit_profile_cubit/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required this._updateProfileUseCase,
  }) : super(const EditProfileInitial());

  final UpdateProfileUseCase _updateProfileUseCase;
  Uint8List? _selectedImageBytes;
  String? _selectedImageExtension;
  String? _selectedImageContentType;

  Uint8List? get selectedImageBytes => _selectedImageBytes;

  void selectProfileImage({
    required Uint8List bytes,
    required String extension,
    required String contentType,
  }) {
    if (state is EditProfileLoading) return;

    final normalizedExtension = extension.toLowerCase();
    final expectedContentType = switch (normalizedExtension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => null,
    };
    if (expectedContentType == null ||
        contentType.toLowerCase() != expectedContentType ||
        !_matchesImageSignature(bytes, expectedContentType)) {
      emit(
        const EditProfileFailure(
          message: 'نوع الصورة غير مدعوم أو أن الملف ليس صورة صالحة',
        ),
      );
      return;
    }

    _selectedImageBytes = bytes;
    _selectedImageExtension = normalizedExtension;
    _selectedImageContentType = expectedContentType;
    emit(const EditProfileImageSelected());
  }

  Future<void> updateProfile({
    required ProfileModel profile,
    required bool isEmailChanged,
  }) async {
    if (state is EditProfileLoading) return;

    emit(const EditProfileLoading());

    // 1. لو الإيميل اتغير
    if (isEmailChanged) {
      try {
        final isEmailUpdated =
            await _updateProfileUseCase.updateEmailProfile(
          profile: profile,
        );

        if (!isEmailUpdated) {
          if (isClosed) return;

          emit(
            const EditProfileFailure(
              message: 'تعذر إرسال طلب تغيير البريد الإلكتروني',
            ),
          );

          return;
        }
      } catch (e) {
        if (isClosed) return;

        emit(
          EditProfileFailure(
            message: e.toString(),
          ),
        );

        return;
      }
    }

    // 2. لو الإيميل تمام أو أصلاً متغيرش
    final result = await _updateProfileUseCase(
      profile: profile,
      imageBytes: _selectedImageBytes,
      imageExtension: _selectedImageExtension,
      contentType: _selectedImageContentType,
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          EditProfileFailure(
            message: failure.message,
          ),
        );
      },
      (updateResult) {
        emit(
          EditProfileSuccess(
            emailConfirmationRequired: false,
            profile: profile,
            cleanupWarning: updateResult.cleanupWarning,
          ),
        );
      },
    );
  }

  bool _matchesImageSignature(Uint8List bytes, String contentType) {
    switch (contentType) {
      case 'image/jpeg':
        return bytes.length >= 3 &&
            bytes[0] == 0xff &&
            bytes[1] == 0xd8 &&
            bytes[2] == 0xff;
      case 'image/png':
        return bytes.length >= 8 &&
            bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4e &&
            bytes[3] == 0x47 &&
            bytes[4] == 0x0d &&
            bytes[5] == 0x0a &&
            bytes[6] == 0x1a &&
            bytes[7] == 0x0a;
      case 'image/webp':
        return bytes.length >= 12 &&
            bytes[0] == 0x52 &&
            bytes[1] == 0x49 &&
            bytes[2] == 0x46 &&
            bytes[3] == 0x46 &&
            bytes[8] == 0x57 &&
            bytes[9] == 0x45 &&
            bytes[10] == 0x42 &&
            bytes[11] == 0x50;
      default:
        return false;
    }
  }
}