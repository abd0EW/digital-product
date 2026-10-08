import 'dart:typed_data';

import 'package:digital_product/features/dashboard_user/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<String?> updateProfile({
    required ProfileModel profile,
    Uint8List? imageBytes,
    String? imageExtension,
    String? contentType,
  });
  Future<bool> updateEmailProfile({required String email});
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  EditProfileRemoteDataSourceImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  @override
  Future<String?> updateProfile({
    required ProfileModel profile,
    Uint8List? imageBytes,
    String? imageExtension,
    String? contentType,
  }) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw const AuthException('User is not authenticated');
    }

    final normalizedName = profile.name?.trim();
    if (normalizedName == null || normalizedName.isEmpty) {
      throw const FormatException('A profile name is required');
    }

    final bytes = imageBytes;
    if (bytes != null) {
      final expectedContentType = switch (imageExtension?.toLowerCase()) {
        'jpg' || 'jpeg' => 'image/jpeg',
        'png' => 'image/png',
        'webp' => 'image/webp',
        _ => null,
      };
      if (bytes.isEmpty ||
          expectedContentType == null ||
          contentType != expectedContentType) {
        throw const FormatException('Invalid profile image data');
      }
    }

    final storage = _client.storage.from('images');
    final uploadedPath = bytes != null
        ? 'profiles/${user.id}/avatar_${DateTime.now().microsecondsSinceEpoch}.$imageExtension'
        : null;

    String? imageUrl;
    if (bytes != null && uploadedPath != null) {
      await storage.uploadBinary(
        uploadedPath,
        bytes,
        fileOptions: FileOptions(upsert: false, contentType: contentType),
      );
      imageUrl = storage.getPublicUrl(uploadedPath);
    }

    try {
      final profileValues = <String, dynamic>{
        'full_name': normalizedName,
        'phone': profile.phone?.trim(),
      };
      if (imageUrl != null) {
        profileValues['image_url'] = imageUrl;
      }

      final updatedProfile = await _client
          .from('profiles')
          .update(profileValues)
          .eq('id', user.id)
          .select('id')
          .maybeSingle();

      if (updatedProfile == null) {
        throw Exception('Profile update did not affect the current user');
      }
    } on Exception catch (exception) {
      if (uploadedPath != null) {
        try {
          await storage.remove([uploadedPath]);
        } on Exception catch (cleanupException) {
          throw Exception(
            '$exception. The newly uploaded image could not be removed: '
            '$cleanupException',
          );
        }
      }
      rethrow;
    }

    if (uploadedPath == null) return null;

    final previousPath = _ownedImagePath(profile.imageUrl, user.id);
    if (previousPath == null || previousPath == uploadedPath) return null;

    try {
      await storage.remove([previousPath]);
      return null;
    } on Exception catch (exception) {
      return 'تم تحديث الصورة، لكن تعذر حذف الصورة القديمة: $exception';
    }
  }



  @override
  Future<bool> updateEmailProfile({required String email}) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw const AuthException('User is not authenticated');
    }

    final currentEmail = user.email!.toLowerCase();
    final newEmail = email.toLowerCase().trim();
    final emailChanged = newEmail != currentEmail;

    if (!emailChanged) {
      return false;
    }

    await _client.auth.updateUser(UserAttributes(email: newEmail));
    print(" Email Send Successfully !");
    return true;
  }



  String? _ownedImagePath(String? imageUrl, String userId) {
    if (imageUrl == null || imageUrl.isEmpty) return null;

    final segments = Uri.tryParse(imageUrl)?.pathSegments;
    if (segments == null) return null;

    final objectIndex = segments.indexOf('object');
    if (objectIndex < 0 ||
        segments.length <= objectIndex + 4 ||
        segments[objectIndex + 1] != 'public' ||
        segments[objectIndex + 2] != 'images') {
      return null;
    }

    final pathSegments = segments.skip(objectIndex + 3).toList();
    if (pathSegments.length < 3 ||
        pathSegments[0] != 'profiles' ||
        pathSegments[1] != userId ||
        pathSegments.any(
          (segment) =>
              segment.isEmpty || segment == '.' || segment == '..' || segment.contains('/'),
        )) {
      return null;
    }

    return pathSegments.join('/');
  }

}
