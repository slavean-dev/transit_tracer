import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  OrdersBloc(this.repository, this.geoService) : super(OrdersInitial()) {
    on<SaveUserOrder>(_saveOrder);

    on<LoadUserOrders>(_loadActiveOrders);

    on<LoadArchivedOrders>(_loadArchivedOrders);
  }

  void _saveOrder(SaveUserOrder event, Emitter<OrdersState> emit) async {
    try {
      emit(ActiveOrdersLoading());
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
      emit(OrderSavedSuccessfull());
    } catch (e) {
      emit(OrderFailure(exception: e.toString()));
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
      emit(ActiveOrdersLoading());
      await emit.forEach<List<OrderData>>(
        repository.getActiveOrders(),
        onData: (orders) {
          if (orders.isEmpty) {
            return ActiveOrdersEmpty();
          } else {
            return ActiveOrdersLoaded(orders: orders);
          }
        },
        onError: (error, stackTrace) =>
            OrderFailure(exception: error.toString()),
      );
    } catch (e) {
      emit(OrderFailure(exception: e.toString()));
    }
  }

  Future<void> _loadArchivedOrders(
    LoadArchivedOrders event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      emit(ArchiveOrdersLoading());
      await emit.forEach(
        repository.getArchivedOrders(),
        onData: (orders) {
          if (orders.isEmpty) {
            return ArchiveOrdersEmpty();
          } else {
            return ArchiveOrdersLoaded(orders: orders);
          }
        },
      );
    } catch (e) {
      emit(OrderFailure(exception: e.toString()));
    }
  }
}
