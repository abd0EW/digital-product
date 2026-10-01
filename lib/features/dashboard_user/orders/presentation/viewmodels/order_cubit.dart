import 'package:digital_product/features/dashboard_user/orders/data/models/order_file_model.dart';
import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_error_message_handler.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_failure.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/create_order_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/save_order_file_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/submit_order_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/upload_order_file_use_case.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/order_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  final CreateOrderUseCase _createOrderUseCase;
  final UploadOrderFileUseCase _uploadOrderFileUseCase;
  final SaveOrderFileUseCase _saveOrderFileUseCase;
  final SubmitOrderUseCase _submitOrderUseCase;
  CreateOrderCubit({
    required CreateOrderUseCase createOrderUseCase,
    required UploadOrderFileUseCase uploadOrderFileUseCase,
    required SaveOrderFileUseCase saveOrderFileUseCase,
    required SubmitOrderUseCase submitOrderUseCase,
  }) : _createOrderUseCase = createOrderUseCase,
       _uploadOrderFileUseCase = uploadOrderFileUseCase,
       _saveOrderFileUseCase = saveOrderFileUseCase,
       _submitOrderUseCase = submitOrderUseCase,

       super(const CreateOrderInitial());

  int _quantity = 1;

  int get quantity => _quantity;

  CreateOrderStep _currentStep = CreateOrderStep.order;

  CreateOrderStep get currentStep => _currentStep;

  PlatformFile? _selectedFile;

  PlatformFile? get selectedFile => _selectedFile;

  bool _showFileError = false;

  bool get showFileError => _showFileError;

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  void showReview() {
    if (_selectedFile == null) {
      _showFileError = true;
      _emitUpdatedState();
      return;
    }

    _showFileError = false;
    _currentStep = CreateOrderStep.review;

    _emitUpdatedState();
  }

  void editOrder() {
    _currentStep = CreateOrderStep.order;

    _emitUpdatedState();
  }

  void increaseQuantity() {
    _quantity++;

    _emitUpdatedState();
  }

  void decreaseQuantity() {
    if (_quantity <= 1) return;

    _quantity--;

    _emitUpdatedState();
  }

  void selectFile(PlatformFile file) {
    _selectedFile = file;
    _showFileError = false;

    _emitUpdatedState();
  }

  void removeFile() {
    _selectedFile = null;

    _emitUpdatedState();
  }

  void _emitUpdatedState() {
    emit(CreateOrderUpdated(quantity: _quantity, step: _currentStep));
  }

  double calculateSubtotal(double price) {
    return price * _quantity;
  }

  double calculateTotal({required double price}) {
    return calculateSubtotal(price);
  }

  Future<void> createOrder({required OrderModel order}) async {
    if (_isSubmitting) return;

    final file = _selectedFile;

    if (file == null) {
      _showFileError = true;
      _emitUpdatedState();
      return;
    }

    _isSubmitting = true;

    emit(CreateOrderLoading(quantity: _quantity, step: _currentStep));

    try {
      final result = await _submitOrderUseCase(order: order, file: file);

      if (isClosed) return;

      result.fold(
        (failure) {
          _emitFailure(failure);
        },
        (createdOrder) {
          _emitSuccess(createdOrder);
        },
      );
    } finally {
      _isSubmitting = false;
    }
  }

  void _emitSuccess(OrderModel order) {
    _currentStep = CreateOrderStep.confirm;

    emit(
      CreateOrderSuccess(order: order, quantity: _quantity, step: _currentStep),
    );
  }

  void _emitFailure(OrderFailure exception) {
    emit(
      CreateOrderFailure(
        failure: OrderErrorMessageHandler.getMessage(exception: exception),
        quantity: _quantity,
        step: _currentStep,
      ),
    );
  }

  String _getMimeType(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';

      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';

      case 'png':
        return 'image/png';

      case 'doc':
        return 'application/msword';

      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';

      default:
        return 'application/octet-stream';
    }
  }
}
