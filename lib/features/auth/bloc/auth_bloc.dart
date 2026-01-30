import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/core/firebase_error_handler/errors/firebase_failure.dart';
import 'package:transit_tracer/features/user/models/user_role/user_role.dart';
import 'package:transit_tracer/features/auth/auth_repository/abstract_auth_repository.dart';

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
    } on FirebaseFailure catch (e) {
      if (e.type == FirebaseErrorType.invalidEmail ||
          e.type == FirebaseErrorType.emailAlreadyInUse) {
        emit(RegisterFailureState(e.type, null));
      } else if (e.type == FirebaseErrorType.weakPassword) {
        emit(RegisterFailureState(null, e.type));
      }
    }
  }

  void _loginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      await authRepository.login(login: event.login, password: event.password);
    } on FirebaseFailure catch (e) {
      if (e.type == FirebaseErrorType.invalidCredential) {
        emit(
          LoginFailureState(
            FirebaseErrorType.invalidCredential,
            FirebaseErrorType.invalidCredential,
          ),
        );
      }
      if (e.type == FirebaseErrorType.invalidEmail ||
          e.type == FirebaseErrorType.userNotFound) {
        emit(LoginFailureState(e.type, null));
      } else if (e.type == FirebaseErrorType.wrongPassword) {
        emit(LoginFailureState(null, e.type));
      }
    }
  }

  void _logoutUser(LogoutUser event, Emitter<AuthState> emit) {
    authRepository.logout();
  }
}
