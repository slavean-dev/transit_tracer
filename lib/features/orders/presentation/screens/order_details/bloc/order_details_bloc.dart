import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/constants/firebase_constants.dart';
import 'package:transit_tracer/core/data/repositories/geo_repository/abstract_geo_repository.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';
import 'package:transit_tracer/core/services/network_service/abstract_network_service.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  final AbstractOrderRepository repository;
  final AbstractNetworkService networkChecker;
  final AbstractGeoRepository geoRepository;

  OrderDetailsBloc(this.repository, this.networkChecker, this.geoRepository)
    : super(OrderDetailsInitial()) {
    on<DeleteUserOrder>(_deleteOrder);

    on<LoadOrderDetails>(_watchOrderDetails);

    on<ToggleArchiveStatus>(_toggleArchiveStatus);
  }
  void _deleteOrder(
    DeleteUserOrder event,
    Emitter<OrderDetailsState> emit,
  ) async {
    try {
      await repository.deleteOrder(event.oid);
      emit(OrderDeletedSuccessfull());
    } on FirebaseFailure catch (e) {
      emit(
        OrderDetailsFailure(
          exception: e.toString(),
          firebaseType: e.type,
          geoType: null,
        ),
      );
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
      );
    } on FirebaseFailure catch (e) {
      emit(
        OrderDetailsFailure(
          exception: e.toString(),
          firebaseType: e.type,
          geoType: null,
        ),
      );
    }
  }

  void _toggleArchiveStatus(
    ToggleArchiveStatus event,
    Emitter<OrderDetailsState> emit,
  ) async {
    try {
      emit(OrderDetailsLoading());
      final bool willBeArchived = !event.order.isArchive;
      final Map<String, dynamic> updates = {
        FirebaseConstants.isArchive: willBeArchived,
      };

      if (event.order.status != OrderStatus.completed) {
        updates[FirebaseConstants.status] = willBeArchived
            ? OrderStatus.archived.name
            : OrderStatus.active.name;
      }
      await repository.toggleArchiveStatus(event.order.oid, updates);
      emit(OrderArchiveSuccessfull());
    } on FirebaseFailure catch (e) {
      emit(
        OrderDetailsFailure(
          exception: e.toString(),
          firebaseType: e.type,
          geoType: null,
        ),
      );
    }
  }
}
