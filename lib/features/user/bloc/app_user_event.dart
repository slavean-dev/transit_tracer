part of 'app_user_bloc.dart';

class AppUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppUserStarted extends AppUserEvent {}

class AppUserReloadRequested extends AppUserEvent {}

class AppUserLogoutRequest extends AppUserEvent {}
