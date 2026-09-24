abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServiceFailure extends Failure {
  final Object exception;

  const ServiceFailure({required String message, required this.exception})
    : super(message);
}
