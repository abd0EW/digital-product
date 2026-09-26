enum UserRole {
  user,
  owner,
  worker;

  String get value => name;

  static UserRole fromString(String value) {
    for (final role in UserRole.values) {
      if (role.name == value) return role;
    }
    throw FormatException('Unsupported user role: $value');
  }
}
