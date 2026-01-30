part of 'auth_bloc.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class RegisterLoading extends AuthState {}

class LoginActive extends AuthState {}

class RegiterActive extends AuthState {}

class RegisterFailureState extends AuthState {
  RegisterFailureState(this.errorEmailType, this.errorPasswordType);
  final FirebaseErrorType? errorEmailType;
  final FirebaseErrorType? errorPasswordType;
  @override
  List<FirebaseErrorType?> get props => [errorEmailType, errorPasswordType];
}

class LoginFailureState extends AuthState {
  LoginFailureState(this.errorEmailType, this.errorPasswordType);
  final FirebaseErrorType? errorEmailType;
  final FirebaseErrorType? errorPasswordType;
  @override
  List<FirebaseErrorType?> get props => [errorEmailType, errorPasswordType];
}
