import 'package:digital_product/features/dashboard_user/orders/data/models/order_model.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/failures/order_error_message_handler.dart';
import 'package:digital_product/features/dashboard_user/orders/domain/usecases/get_orders_usecase.dart';
import 'package:digital_product/features/dashboard_user/orders/presentation/viewmodels/get_order/get_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOrderCubit extends Cubit<GetOrderState> {
  final GetOrdersUsecase _getOrdersUsecase;

  GetOrderCubit({required this._getOrdersUsecase})
    : super(const GetOrderInitial());

  List<OrderModel> _allOrders = const [];

  String? _selectedStatus;

  bool _hasLoadedOrders = false;
  bool _isFetching = false;

  List<OrderModel> get allOrders => _allOrders;

  Future<void> getOrders() async {
    if (_hasLoadedOrders) return;

    if (_isFetching) return;

    _isFetching = true;

    emit(const GetOrderLoading());

    try {
      final result = await _getOrdersUsecase();

      if (isClosed) return;

      result.fold(
        (failure) {
          emit(
            GetOrderFailure(
              OrderErrorMessageHandler.getMessage(exception: failure),
            ),
          );
        },
        (orders) {
          _allOrders = List.unmodifiable(orders);

          _hasLoadedOrders = true;

          _emitFilteredOrders();
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(const GetOrderFailure('تعذر تحميل الطلبات. حاول مرة أخرى.'));
      }
    } finally {
      _isFetching = false;
    }
  }

  void filterOrders(String? status) {
    if (_selectedStatus == status) return;

    _selectedStatus = status;

    if (!_hasLoadedOrders) return;

    _emitFilteredOrders();
  }

  void _emitFilteredOrders() {
    final orders = _getFilteredOrders();

    if (orders.isEmpty) {
      emit(const GetOrderEmpty());
      return;
    }

    emit(GetOrderSuccess(orders));
  }

  List<OrderModel> _getFilteredOrders() {
    if (_selectedStatus == null) {
      return _allOrders;
    }

    return _allOrders
        .where((order) => order.status == _selectedStatus)
        .toList();
  }

  Future<void> refreshOrders() async {
    _hasLoadedOrders = false;

    await getOrders();
  }
}
