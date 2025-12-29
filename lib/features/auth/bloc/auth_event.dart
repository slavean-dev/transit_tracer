part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartLogin extends AuthEvent {}

class StartRegistration extends AuthEvent {}

class RegisterUser extends AuthEvent {
  RegisterUser({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.password,
    required this.userRole,
  });

  final String name;
  final String surname;
  final String email;
  final String phone;
  final String password;
  final UserRole userRole;

  @override
  List<Object?> get props => [name, surname, email, phone, password, userRole];
}

class LoginUser extends AuthEvent {
  LoginUser({required this.login, required this.password});
  final String login;
  final String password;

  @override
  List<String> get props => [login, password];
}

class LogoutUser extends AuthEvent {}
