import 'package:digital_product/core/errors/app_fail.dart';

abstract class OrderFailure extends AppFail {
  final String message;

  const OrderFailure({required this.message}) : super(message: message);
}

class CreateOrderFail extends OrderFailure {
  final Object exception;

  const CreateOrderFail({required String message, required this.exception})
    : super(message: message);
}

class UploadFileFailure extends OrderFailure {
  final Object exception;

  const UploadFileFailure({required String message, required this.exception})
    : super(message: message);
}

class UnauthorizedOrderFailure extends OrderFailure {
  const UnauthorizedOrderFailure() : super(message: 'Unauthorized');
}

class NetworkOrderFailure extends OrderFailure {
  const NetworkOrderFailure() : super(message: 'Network error');
}

class FileTooLargeFailure extends OrderFailure {
  const FileTooLargeFailure() : super(message: 'File too large');
}

class UnsupportedFileFailure extends OrderFailure {
  final String message;
  const UnsupportedFileFailure({required this.message})
    : super(message: message);
}
