import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final AbstractOrderRepository repository;
  OrdersBloc(this.repository) : super(OrdersInitial()) {
    on<SaveUserOrder>(_saveOrder);

    on<LoadUserOrders>(_loadOrders);
  }

  void _saveOrder(SaveUserOrder event, Emitter<OrdersState> emit) async {
    try {
      emit(OrdersLoading());
      await repository.saveOrder(
        event.from,
        event.to,
        event.description,
        event.weight,
        event.price,
      );
      emit(OrderSavedSuccessfull());
    } catch (e) {
      emit(OrderFailure(exception: e.toString()));
    }
  }

  Future<void> _loadOrders(
    LoadUserOrders event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      emit(OrdersLoading());
      await emit.forEach<List<OrderData>>(
        repository.getOrders(),
        onData: (orders) {
          if (orders.isEmpty) {
            return OrdersEmpty();
          } else {
            return OrdersLoaded(orders: orders);
          }
        },
        onError: (error, stackTrace) =>
            OrderFailure(exception: error.toString()),
      );
    } catch (e) {
      emit(OrderFailure(exception: e.toString()));
    }
  }
}
