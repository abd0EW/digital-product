class ProfileModel {
  ProfileModel({
    required this.email,
    required this.name,
    required this.phone,
    this.isEditing = false,
  });

  String? name;
  String? email;
  String? phone;
  bool isEditing;
}
