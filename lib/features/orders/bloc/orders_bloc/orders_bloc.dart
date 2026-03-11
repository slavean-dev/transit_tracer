import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/constants/firebase_constants.dart';
import 'package:transit_tracer/core/data/repositories/geo_repository/abstract_geo_repository.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/errors/geo_failure.dart';
import 'package:transit_tracer/core/error_handlers/geo_error_handler/geo_error_type/geo_error_type.dart';
import 'package:transit_tracer/features/city_autocomplete/data/model/city_suggestion/city_suggestion.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final AbstractOrderRepository repository;
  final AbstractGeoRepository geoRepository;

  OrdersBloc(this.repository, this.geoRepository) : super(OrdersState()) {
    on<SaveUserOrder>(_saveOrder);

    on<LoadUserOrders>(_loadActiveOrders);

    on<LoadArchivedOrders>(_loadArchivedOrders);
  }

  void _saveOrder(SaveUserOrder event, Emitter<OrdersState> emit) async {
    try {
      emit(
        state.copyWith(
          ordersStatus: OrderStateStatus.loading,
          geoType: null,
          firebaseType: null,
          error: null,
        ),
      );
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
      emit(state.copyWith(ordersStatus: OrderStateStatus.success));
    } on FirebaseFailure catch (e) {
      emit(
        state.copyWith(
          ordersStatus: OrderStateStatus.error,
          firebaseType: e.type,
          error: e.toString(),
        ),
      );
    } on GeoFailure catch (e) {
      emit(
        state.copyWith(
          ordersStatus: OrderStateStatus.error,
          geoType: e.type,
          error: e.message,
        ),
      );
    }
  }

  Future<void> _loadActiveOrders(
    LoadUserOrders event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      emit(state.copyWith(activeStatus: OrderStateStatus.loading));
      final streamTask = emit.forEach<List<OrderData>>(
        repository.getActiveOrders(),
        onData: (orders) {
          if (orders.isNotEmpty) {
            return state.copyWith(
              activeStatus: OrderStateStatus.loaded,
              activeOrders: orders,
            );
          }

          return state.copyWith(activeOrders: orders);
        },

        onError: (error, stackTrace) {
          return state.copyWith(
            activeStatus: OrderStateStatus.error,
            firebaseType: error is FirebaseFailure
                ? error.type
                : FirebaseErrorType.unknown,
          );
        },
      );
      await Future.delayed(const Duration(milliseconds: 500));

      if (state.activeStatus == OrderStateStatus.loading &&
          state.activeOrders.isEmpty) {
        emit(state.copyWith(activeStatus: OrderStateStatus.empty));
      }

      await streamTask;
    } on FirebaseFailure catch (e) {
      emit(
        state.copyWith(
          activeStatus: OrderStateStatus.error,
          firebaseType: e.type,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _loadArchivedOrders(
    LoadArchivedOrders event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      emit(state.copyWith(archiveStatus: OrderStateStatus.loading));

      final streamTask = emit.forEach<List<OrderData>>(
        repository.getArchivedOrders(),
        onData: (orders) {
          if (orders.isNotEmpty) {
            return state.copyWith(
              archiveStatus: OrderStateStatus.loaded,
              archiveOrders: orders,
            );
          }

          return state.copyWith(archiveOrders: orders);
        },
        onError: (error, stackTrace) {
          return state.copyWith(
            archiveStatus: OrderStateStatus.error,
            firebaseType: error is FirebaseFailure
                ? error.type
                : FirebaseErrorType.unknown,
          );
        },
      );

      await Future.delayed(const Duration(milliseconds: 500));

      if (state.archiveStatus == OrderStateStatus.loading &&
          state.archiveOrders.isEmpty) {
        emit(state.copyWith(archiveStatus: OrderStateStatus.empty));
      }

      await streamTask;
    } on FirebaseFailure catch (e) {
      emit(
        state.copyWith(
          archiveStatus: OrderStateStatus.error,
          firebaseType: e.type,
          error: e.toString(),
        ),
      );
    }
  }
}
