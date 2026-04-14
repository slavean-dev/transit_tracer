part of 'order_details_bloc.dart';

sealed class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object?> get props => [];
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
  const OrderDetailsFailure({
    required this.exception,
    this.firebaseType,
    this.geoType,
  });
  final String exception;
  final FirebaseErrorType? firebaseType;
  final GeoErrorType? geoType;

  @override
  List<Object?> get props => [exception, firebaseType, geoType];
}

class OrderDataEditedSuccessfull extends OrderDetailsState {}

class StateUpdatePendingLater extends OrderDetailsState {}

class OrderArchiveSuccessfull extends OrderDetailsState {}
