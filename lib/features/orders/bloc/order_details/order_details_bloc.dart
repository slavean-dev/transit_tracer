import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/services/geo_service/geo_service.dart';
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
  final GeoService geoService;

  OrderDetailsBloc(this.repository, this.networkChecker, this.geoService)
    : super(OrderDetailsInitial()) {
    on<DeleteUserOrder>(_deleteOrder);

    on<LoadOrderDetails>(_watchOrderDetails);

    on<EditOrderData>(_editOrder);

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
      );
    } on FirebaseFailure catch (e) {
      emit(OrderDetailsFailure(exception: e.toString(), type: e.type));
    }
  }

  void _editOrder(EditOrderData event, Emitter<OrderDetailsState> emit) async {
    try {
      emit(OrderDetailsLoading());
      Map<String, String> fromNames = event.from.localizedNames;
      Map<String, String> toNames = event.to.localizedNames;
      if (event.oldFromCityId != event.from.placeId) {
        fromNames = await _getCityTranslation(event.from.placeId);
      }
      if (event.oldToCityId != event.to.placeId) {
        toNames = await _getCityTranslation(event.to.placeId);
      }
      final from = event.from.copyWith(localizedNames: fromNames);
      final to = event.to.copyWith(localizedNames: toNames);
      final order = OrderData(
        from: from,
        to: to,
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

      await repository.editOrderData(order);
      emit(OrderDataEditedSuccessfull());
    } on FirebaseFailure catch (e) {
      emit(OrderDetailsFailure(exception: e.toString(), type: e.type));
    }
  }

  Future<Map<String, String>> _getCityTranslation(String placeId) async {
    try {
      final results = await Future.wait([
        geoService.getLocaliredPlaceName(placeId, 'en'),
        geoService.getLocaliredPlaceName(placeId, 'uk'),
        geoService.getLocaliredPlaceName(placeId, 'it'),
      ]);
      return {'en': results[0], 'uk': results[1], 'it': results[2]};
    } catch (e) {
      return {};
    }
  }

  void _toggleArchiveStatus(
    ToggleArchiveStatus event,
    Emitter<OrderDetailsState> emit,
  ) async {
    try {
      emit(OrderDetailsLoading());
      final bool willBeArchived = !event.order.isArchive;
      final Map<String, dynamic> updates = {'isArchive': willBeArchived};

      if (event.order.status != OrderStatus.completed) {
        updates['status'] = willBeArchived
            ? OrderStatus.archived.name
            : OrderStatus.active.name;
      }
      await repository.toggleArchiveStatus(event.order.oid, updates);
      emit(OrderArchiveSuccessfull());
    } on FirebaseFailure catch (e) {
      emit(OrderDetailsFailure(exception: e.toString(), type: e.type));
    }
  }
}
