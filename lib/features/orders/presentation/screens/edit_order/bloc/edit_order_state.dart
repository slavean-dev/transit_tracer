part of 'edit_order_bloc.dart';

class EditOrderState extends Equatable {
  const EditOrderState();

  @override
  List<Object?> get props => [];
}

class EditOrderInitial extends EditOrderState {}

class EditOrderLoading extends EditOrderState {}

class EditOrderSuccessfull extends EditOrderState {}

class StateUpdatePendingLater extends EditOrderState {}

class EditOrderFailure extends EditOrderState {
  const EditOrderFailure({
    required this.exception,
    required this.firebaseType,
    required this.geoType,
  });
  final String exception;
  final FirebaseErrorType? firebaseType;
  final GeoErrorType? geoType;

  @override
  List<Object?> get props => [exception, firebaseType, geoType];
}
