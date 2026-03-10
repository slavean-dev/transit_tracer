import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/constants/firebase_constants.dart';
import 'package:transit_tracer/core/constants/google_api_constants.dart';
import 'package:transit_tracer/core/data/repositories/geo_repository/abstract_geo_repository.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/errors/geo_failure.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';
import 'package:transit_tracer/core/services/network_service/network_service.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
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
  final AbstractGeoRepository geoRepository;

  OrderDetailsBloc(this.repository, this.networkChecker, this.geoRepository)
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

  void _editOrder(EditOrderData event, Emitter<OrderDetailsState> emit) async {
    try {
      emit(OrderDetailsLoading());
      (Map<String, String>, Map<String, double>) fromData = (
        event.oldFrom.localizedNames,
        {
          GoogleApiConstants.lat: event.oldFrom.lat,
          GoogleApiConstants.lng: event.oldFrom.lng,
        },
      );
      (Map<String, String>, Map<String, double>) toData = (
        event.oldTo.localizedNames,
        {
          GoogleApiConstants.lat: event.oldTo.lat,
          GoogleApiConstants.lng: event.oldTo.lng,
        },
      );
      if (event.oldFrom.placeId != event.fromSuggestion.placeId) {
        fromData = await geoRepository.getCityFullBundle(
          event.fromSuggestion.placeId,
        );
      }
      if (event.oldTo.placeId != event.toSuggestion.placeId) {
        toData = await geoRepository.getCityFullBundle(
          event.toSuggestion.placeId,
        );
      }
      final from = CityPoint(
        name: event.fromSuggestion.cityName,
        placeId: event.fromSuggestion.placeId,
        lat: fromData.$2[FirebaseConstants.lat] ?? 0.0,
        lng: fromData.$2[FirebaseConstants.lng] ?? 0.0,
        localizedNames: fromData.$1,
      );
      final to = CityPoint(
        name: event.toSuggestion.cityName,
        placeId: event.toSuggestion.placeId,
        lat: toData.$2[FirebaseConstants.lat] ?? 0.0,
        lng: toData.$2[FirebaseConstants.lng] ?? 0.0,
        localizedNames: toData.$1,
      );
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
      emit(
        OrderDetailsFailure(
          exception: e.toString(),
          firebaseType: e.type,
          geoType: null,
        ),
      );
    } on GeoFailure catch (e) {
      emit(
        OrderDetailsFailure(
          exception: e.message ?? '',
          geoType: e.type,
          firebaseType: null,
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
