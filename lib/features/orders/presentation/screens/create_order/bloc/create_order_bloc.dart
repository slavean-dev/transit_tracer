import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/constants/firebase_constants.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';
import 'package:transit_tracer/core/data/repositories/geo_repository/abstract_geo_repository.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/errors/geo_failure.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final AbstractOrderRepository repository;
  final AbstractGeoRepository geoRepository;

  CreateOrderBloc({required this.repository, required this.geoRepository})
    : super(CreateOrderInitial()) {
    on<SaveUserOrder>(_saveOrder);
  }
  void _saveOrder(SaveUserOrder event, Emitter<CreateOrderState> emit) async {
    try {
      emit(CreateOrderLoading());
      final results = await Future.wait([
        geoRepository.getCityFullBundle(event.from.placeId),
        geoRepository.getCityFullBundle(event.to.placeId),
      ]);

      final from = CityPoint(
        name: event.from.cityName,
        placeId: event.from.placeId,
        lat: results[0].$2[FirebaseConstants.lat] ?? 0.0,
        lng: results[0].$2[FirebaseConstants.lng] ?? 0,
        localizedNames: results[0].$1,
      );
      final to = CityPoint(
        name: event.to.cityName,
        placeId: event.to.placeId,
        lat: results[1].$2[FirebaseConstants.lat] ?? 0.0,
        lng: results[1].$2[FirebaseConstants.lng] ?? 0,
        localizedNames: results[1].$1,
      );
      await repository.saveOrder(
        from,
        to,
        event.description,
        event.weight,
        event.price,
      );
      emit(CreateOrderSuccess());
    } on FirebaseFailure catch (e) {
      emit(
        CreateOrderFailure(
          geoType: null,
          firebaseType: e.type,
          error: e.toString(),
        ),
      );
    } on GeoFailure catch (e) {
      emit(
        CreateOrderFailure(
          firebaseType: null,
          geoType: e.type,
          error: e.message,
        ),
      );
    }
  }
}
