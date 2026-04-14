part of 'create_order_bloc.dart';

class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object?> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderSuccess extends CreateOrderState {}

class CreateOrderFailure extends CreateOrderState {
  const CreateOrderFailure({this.error, this.firebaseType, this.geoType});

  final String? error;
  final FirebaseErrorType? firebaseType;
  final GeoErrorType? geoType;

  @override
  List<Object?> get props => [error ?? '', firebaseType, geoType];
}
