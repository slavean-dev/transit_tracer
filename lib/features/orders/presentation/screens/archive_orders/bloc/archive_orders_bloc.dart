import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/core/error_handlers/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/features/orders/data/models/order_data/order_data.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';

part 'archive_orders_event.dart';
part 'archive_orders_state.dart';

class ArchiveOrdersBloc extends Bloc<ArchiveOrdersEvent, ArchiveOrdersState> {
  final AbstractOrderRepository repository;

  ArchiveOrdersBloc({required this.repository})
    : super(ArchiveOrdersInitial()) {
    on<LoadArchivedOrders>(_loadArchivedOrders);
  }

  Future<void> _loadArchivedOrders(
    LoadArchivedOrders event,
    Emitter<ArchiveOrdersState> emit,
  ) async {
    try {
      emit(ArchiveOrdersLoading());

      await emit.forEach<List<OrderData>>(
        repository.getArchivedOrders(),
        onData: (orders) {
          if (orders.isNotEmpty) {
            return ArchiveOrdersLoaded(orders: orders);
          } else {
            return ArchiveOrdersEmpty();
          }
        },
        onError: (error, stackTrace) {
          return ArchiveOrdersError(
            error: error.toString(),
            firebaseType: error is FirebaseFailure
                ? error.type
                : FirebaseErrorType.unknown,
          );
        },
      );
    } on FirebaseFailure catch (e) {
      emit(ArchiveOrdersError(firebaseType: e.type, error: e.toString()));
    }
  }
}
