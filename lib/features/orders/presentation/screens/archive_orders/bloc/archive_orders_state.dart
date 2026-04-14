part of 'archive_orders_bloc.dart';

class ArchiveOrdersState extends Equatable {
  const ArchiveOrdersState();

  @override
  List<Object> get props => [];
}

class ArchiveOrdersInitial extends ArchiveOrdersState {}

class ArchiveOrdersLoading extends ArchiveOrdersState {}

class ArchiveOrdersEmpty extends ArchiveOrdersState {}

class ArchiveOrdersLoaded extends ArchiveOrdersState {
  final List<OrderData> orders;

  const ArchiveOrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class ArchiveOrdersError extends ArchiveOrdersState {
  final String? error;
  final FirebaseErrorType? firebaseType;

  const ArchiveOrdersError({this.error, this.firebaseType});

  @override
  List<Object> get props => [
    error ?? '',
    firebaseType ?? FirebaseErrorType.unknown,
  ];
}
