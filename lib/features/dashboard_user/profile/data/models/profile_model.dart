import 'package:digital_product/features/auth/domain/enums/user_role.dart';

class ProfileModel {
  const ProfileModel({
    required this.email,
    required this.name,
    required this.phone,
    this.imageUrl,
    this.role,
  });

  final String? name;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final UserRole? role;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['full_name'] as String?,
      imageUrl: json['image_url'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] == null
          ? null
          : UserRole.fromString(json['role'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'email': email,
      'phone': phone,
      'image_url': imageUrl,
    };
  }
}
