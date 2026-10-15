import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/create_order/order_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(const CreateOrderInitial());

  int _quantity = 1;

  int get quantity => _quantity;

  CreateOrderStep _currentStep = CreateOrderStep.order;

  CreateOrderStep get currentStep => _currentStep;

  PlatformFile? _selectedFile;

  PlatformFile? get selectedFile => _selectedFile;

  bool _showFileError = false;

  bool get showFileError => _showFileError;

  void showReview() {
    if (!validateSelectedFile()) return;
    _currentStep = CreateOrderStep.review;

    _emitUpdatedState();
  }

  bool validateSelectedFile() {
    if (_selectedFile == null) {
      _showFileError = true;
      _emitUpdatedState();
      return false;
    }

    _showFileError = false;
    return true;
  }

  void editOrder() {
    _currentStep = CreateOrderStep.order;

    _emitUpdatedState();
  }

  void showConfirmation() {
    _currentStep = CreateOrderStep.confirm;

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

  //calac
  double calculateSubtotal(double price) {
    return price * _quantity;
  }

  double calculateTotal({required double price}) {
    return calculateSubtotal(price);
  }
}
