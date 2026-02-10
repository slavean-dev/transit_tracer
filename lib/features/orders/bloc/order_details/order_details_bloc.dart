import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/services/network_service/network_service.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  final AbstractOrderRepository repository;
  final NetworkService networkChecker;

  OrderDetailsBloc(this.repository, this.networkChecker)
    : super(OrderDetailsInitial()) {
    on<DeleteUserOrder>(_deleteOrder);

    on<LoadOrderDetails>(_watchOrderDetails);

    on<EditOrderData>(_editOrder);

    on<ArchiveOrder>(_archiveOrder);
  }
  void _deleteOrder(
    DeleteUserOrder event,
    Emitter<OrderDetailsState> emit,
  ) async {
    try {
      await repository.deleteOrder(event.oid);
    } on FirebaseFailure catch (e) {
      emit(OrderDetailsFailure(exception: e.toString(), type: e.type));
    }
  }

  Future<void> _watchOrderDetails(
    LoadOrderDetails event,
    Emitter<OrderDetailsState> emit,
  ) async {
    try {
      emit(OrderDetailsLoading());
      await emit.forEach(
        repository.getOrderById(event.oid),
        onData: (order) {
          return OrderDetailsLoaded(order: order);
        },
        onError: (error, stackTrace) => OrderDeletedSuccessfull(),
      );
    } on FirebaseFailure catch (e) {
      emit(OrderDetailsFailure(exception: e.toString(), type: e.type));
    }
  }

  void _editOrder(EditOrderData event, Emitter<OrderDetailsState> emit) async {
    emit(OrderDetailsLoading());
    final order = OrderData(
      from: event.from,
      to: event.to,
      description: event.description,
      weight: event.weight,
      price: event.price,
      uid: event.uid,
      oid: event.oid,
      status: event.status,
      createdAt: event.createdAt,
    );
    if (!await networkChecker.isConnected) {
      repository.editOrderData(order);
      await Future.delayed(const Duration(seconds: 2));
      emit(StateUpdatePendingLater());
      return;
    }
    try {
      await repository.editOrderData(order);
      emit(OrderDataEditedSuccessfull());
    } on FirebaseFailure catch (e) {
      emit(OrderDetailsFailure(exception: e.toString(), type: e.type));
    }
  }

  void _archiveOrder(
    ArchiveOrder event,
    Emitter<OrderDetailsState> emit,
  ) async {
    try {
      emit(OrderDetailsLoading());
      await repository.archiveOrder(event.oid);
      emit(OrderArchiveSuccessfull());
    } on FirebaseFailure catch (e) {
      emit(OrderDetailsFailure(exception: e.toString(), type: e.type));
    }
  }
}
