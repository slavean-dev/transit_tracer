import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/services/geo_service/geo_service.dart';
import 'package:transit_tracer/features/orders/data/models/city_point/city_point.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/core/data/models/weight_range/weight_range.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final AbstractOrderRepository repository;
  final GeoService geoService;

  OrdersBloc(this.repository, this.geoService) : super(OrdersState()) {
    on<SaveUserOrder>(_saveOrder);

    on<LoadUserOrders>(_loadActiveOrders);

    on<LoadArchivedOrders>(_loadArchivedOrders);
  }

  void _saveOrder(SaveUserOrder event, Emitter<OrdersState> emit) async {
    try {
      emit(state.copyWith(ordersStatus: OrderStateStatus.loading));
      final results = await Future.wait([
        _getCityTranslation(event.from.placeId),
        _getCityTranslation(event.to.placeId),
      ]);

      final from = event.from.copyWith(localizedNames: results[0]);
      final to = event.to.copyWith(localizedNames: results[1]);
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
          type: e.type,
          error: e.toString(),
        ),
      );
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
            type: error is FirebaseFailure
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
          type: e.type,
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
            type: error is FirebaseFailure
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
          type: e.type,
          error: e.toString(),
        ),
      );
    }
  }
}
