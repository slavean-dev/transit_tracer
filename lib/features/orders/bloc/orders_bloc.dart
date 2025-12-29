import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/orders/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/models/weight_range/weight_range.dart';
import 'package:transit_tracer/features/orders/order_data_repository/abstract_order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final AbstractOrderRepository repository;
  OrdersBloc(this.repository) : super(OrdersInitial()) {
    on<SaveUserOrder>(_saveOrder);

    on<LoadUserOrders>(_loadOrders);

    on<DeleteUserOrder>(_deleteOrder);
  }

  void _saveOrder(SaveUserOrder event, Emitter<OrdersState> emit) async {
    try {
      emit(OrdersLoading());
      await repository.saveOrder(
        event.from,
        event.to,
        event.discription,
        event.weight,
        event.price,
      );
      emit(OrderSavedSuccessfull());
    } catch (e) {
      emit(OrderFailure(exception: e.toString()));
    }
  }

  void _loadOrders(LoadUserOrders event, Emitter<OrdersState> emit) async {
    try {
      emit(OrdersLoading());
      final orders = await repository.loadOrders();
      if (orders.isEmpty) {
        emit(OrdersEmpty());
      } else {
        emit(OrdersLoaded(orders: orders));
      }
    } catch (e) {
      emit(OrderFailure(exception: e.toString()));
    }
  }

  void _deleteOrder(DeleteUserOrder event, Emitter<OrdersState> emit) async {
    try {
      await repository.deleteOrder(event.oid);
      emit(OrderDeletedSuccessfull());
    } catch (e) {
      emit(OrderFailure(exception: e.toString()));
    }
  }
}
