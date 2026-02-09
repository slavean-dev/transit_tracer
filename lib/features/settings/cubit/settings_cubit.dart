import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:transit_tracer/core/services/network_service/network_service.dart';
import 'package:transit_tracer/features/settings/settings_reposytory/abstract_settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repo, this._networkService)
    : super(const SettingsState());

  final AbstractSettingsRepository _repo;

  final NetworkService _networkService;

  StreamSubscription? _networkSubscription;

  Future<void> init() async {
    final theme = await _repo.loadThemeMode();
    final lang = await _repo.loadLangCode();

    final bool initialOnline = await _networkService.isConnected;

    emit(state.copyWith(mode: theme, langCode: lang, isOnline: initialOnline));

    _networkSubscription = _networkService.status.listen((status) {
      final bool hasInternet = status == InternetStatus.connected;
      if (state.isOnline != hasInternet) {
        emit(state.copyWith(isOnline: hasInternet));
      }
    });
  }

  @override
  Future<void> close() {
    _networkSubscription?.cancel();
    return super.close();
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _repo.saveThemeMode(mode);
    emit(state.copyWith(mode: mode));
  }

  Future<void> toggleDarkLight() async {
    final next = state.mode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await setTheme(next);
  }

  Future<void> setLangCode(String code) async {
    await _repo.saveLocale(code);

    emit(state.copyWith(langCode: code));
  }
}
