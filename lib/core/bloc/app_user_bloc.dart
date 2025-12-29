import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/data/repositories/auth_repository/abstract_auth_repository.dart';
import 'package:transit_tracer/core/data/repositories/user_data_repository/abstract_user_data.dart';
import 'package:transit_tracer/core/models/app_user_state/app_user_status.dart';
import 'package:transit_tracer/core/models/user_data/user_data.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  final AbstractAuthRepository _abstractAuthRepository;
  final AbstractUserDataRepository _abstractUserDataRepository;
  AppUserBloc({
    required AbstractAuthRepository abstractAuthRepository,
    required AbstractUserDataRepository abstractUserDataRepository,
  }) : _abstractAuthRepository = abstractAuthRepository,
       _abstractUserDataRepository = abstractUserDataRepository,
       super(AppUserState.initial()) {
    on<AppUserStarted>(_onStarted);

    on<AppUserReloadRequested>(_onReloadRequest);

    on<AppUserLogoutRequest>(_onLogoutRequest);
  }

  Future<void> _onStarted(
    AppUserStarted event,
    Emitter<AppUserState> emit,
  ) async {
    emit(state.copyWith(status: AppUserStatus.loading, errorMassage: null));

    final firebaseUser = _abstractAuthRepository.currentUser;

    if (firebaseUser == null) {
      emit(state.copyWith(status: AppUserStatus.unauthorized, user: null));
      return;
    }

    try {
      final userData = await _abstractUserDataRepository.loadUserData();

      emit(
        state.copyWith(
          status: AppUserStatus.authorized,
          user: userData,
          errorMassage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AppUserStatus.failure,
          errorMassage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onReloadRequest(
    AppUserReloadRequested event,
    Emitter<AppUserState> emit,
  ) async {
    add(AppUserStarted());
  }

  Future<void> _onLogoutRequest(
    AppUserLogoutRequest event,
    Emitter<AppUserState> emit,
  ) async {
    await _abstractAuthRepository.logout();

    emit(
      state.copyWith(
        status: AppUserStatus.unauthorized,
        user: null,
        errorMassage: null,
      ),
    );
  }
}
