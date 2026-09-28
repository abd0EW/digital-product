abstract class AppFail implements Exception {
  final String message;
  final String? code;

  const AppFail({required this.message, this.code});

  @override
  String toString() => message;
}
