import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/constants/firebase_constants.dart';
import 'package:transit_tracer/core/constants/google_api_constants.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';
import 'package:transit_tracer/core/data/repositories/geo_repository/abstract_geo_repository.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/errors/geo_failure.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';
import 'package:transit_tracer/core/services/network_service/abstract_network_service.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/data/models/order_status/order_status.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'edit_order_event.dart';
part 'edit_order_state.dart';

class EditOrderBloc extends Bloc<EditOrderEvent, EditOrderState> {
  final AbstractOrderRepository repository;
  final AbstractGeoRepository geoRepository;
  final AbstractNetworkService networkChecker;

  EditOrderBloc({
    required this.repository,
    required this.geoRepository,
    required this.networkChecker,
  }) : super(EditOrderInitial()) {
    on<EditOrderData>(_editOrder);
  }

  void _editOrder(EditOrderData event, Emitter<EditOrderState> emit) async {
    try {
      emit(EditOrderLoading());
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
      emit(EditOrderSuccessfull());
    } on FirebaseFailure catch (e) {
      emit(
        EditOrderFailure(
          exception: e.toString(),
          firebaseType: e.type,
          geoType: null,
        ),
      );
    } on GeoFailure catch (e) {
      emit(
        EditOrderFailure(
          exception: e.message ?? '',
          geoType: e.type,
          firebaseType: null,
        ),
      );
    }
  }
}
