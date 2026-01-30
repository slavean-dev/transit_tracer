part of 'order_details_bloc.dart';

sealed class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

final class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDeletedSuccessfull extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {
  const OrderDetailsLoaded({required this.order});

  final OrderData order;

  @override
  List<OrderData> get props => [order];
}

class OrderDetailsFailure extends OrderDetailsState {
  const OrderDetailsFailure({required this.exception, required this.type});
  final String exception;
  final FirebaseErrorType type;

  @override
  List<Object> get props => [exception, type];
}

class OrderDataEditedSuccessfull extends OrderDetailsState {}

class StateUpdatePendingLater extends OrderDetailsState {}

class OrderArchiveSuccessfull extends OrderDetailsState {}
