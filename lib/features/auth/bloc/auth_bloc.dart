import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/models/auth_error_type/auth_error_type.dart';
import 'package:transit_tracer/features/auth/errors/auth_failure.dart';
import 'package:transit_tracer/core/models/user_role/user_role.dart';
import 'package:transit_tracer/core/data/repositories/auth_repository/abstract_auth_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<StartLogin>(_startLogin);

    on<StartRegistration>(_startRegistration);

    on<RegisterUser>(_registerUser);

    on<LoginUser>(_loginUser);

    on<LogoutUser>(_logoutUser);
  }

  void _startLogin(StartLogin event, Emitter<AuthState> emit) {
    emit(LoginActive());
  }

  void _startRegistration(StartRegistration event, Emitter<AuthState> emit) {
    emit(RegiterActive());
  }

  void _registerUser(RegisterUser event, Emitter<AuthState> emit) async {
    emit(RegisterLoading());
    try {
      await authRepository.register(
        name: event.name,
        surname: event.surname,
        email: event.email,
        phone: event.phone,
        password: event.password,
        role: event.userRole,
      );
    } on AuthFailure catch (e) {
      if (e.type == AuthErrorType.invalidEmail ||
          e.type == AuthErrorType.emailAlreadyInUse) {
        emit(RegisterFailureState(e.type, null));
      } else if (e.type == AuthErrorType.weakPassword) {
        emit(RegisterFailureState(null, e.type));
      }
    }
  }

  void _loginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      await authRepository.login(login: event.login, password: event.password);
    } on AuthFailure catch (e) {
      if (e.type == AuthErrorType.invalidEmail ||
          e.type == AuthErrorType.userNotFound) {
        emit(LoginFailureState(e.type, null));
      } else if (e.type == AuthErrorType.wrongPassword) {
        emit(LoginFailureState(null, e.type));
      }
    }
  }

  void _logoutUser(LogoutUser event, Emitter<AuthState> emit) {
    authRepository.logout();
  }
}
