part of 'app_user_bloc.dart';

class AppUserState extends Equatable {
  const AppUserState({required this.status, this.user, this.errorMassage});
  final AppUserStatus status;
  final UserData? user;
  final String? errorMassage;

  factory AppUserState.initial() {
    return const AppUserState(status: AppUserStatus.initial);
  }

  AppUserState copyWith({
    AppUserStatus? status,
    UserData? user,
    String? errorMassage,
  }) {
    return AppUserState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMassage: errorMassage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMassage];
}
