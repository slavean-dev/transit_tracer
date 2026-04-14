import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'orders_list_event.dart';
part 'orders_list_state.dart';

class OrdersListBloc extends Bloc<OrdersListEvent, OrdersListState> {
  final AbstractOrderRepository repository;
  OrdersListBloc({required this.repository}) : super(OrdersListInitial()) {
    on<LoadUserOrders>(_loadActiveOrders);
  }
  Future<void> _loadActiveOrders(
    LoadUserOrders event,
    Emitter<OrdersListState> emit,
  ) async {
    try {
      emit(OrdersListLoading());
      await emit.forEach<List<OrderData>>(
        repository.getActiveOrders(),
        onData: (orders) {
          if (orders.isNotEmpty) {
            return OrdersListLoaded(orders: orders);
          } else {
            return OrderListEmpty();
          }
        },

        onError: (error, stackTrace) {
          return OrdersListError(
            error: error.toString(),
            firebaseType: error is FirebaseFailure
                ? error.type
                : FirebaseErrorType.unknown,
          );
        },
      );
    } on FirebaseFailure catch (e) {
      emit(OrdersListError(firebaseType: e.type, error: e.toString()));
    }
  }
}
