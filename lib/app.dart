import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/core/theme/theme.dart';
import 'package:transit_tracer/generated/l10n.dart';

class TransitTracerApp extends StatefulWidget {
  const TransitTracerApp({super.key});

  @override
  State<TransitTracerApp> createState() => _TransitTracerAppState();
}

class _TransitTracerAppState extends State<TransitTracerApp> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        // ThemeMode themeMode = ThemeMode.system;
        // String langCode = 'en';
        // if (state is SettingsDataLoaded) {
        //   themeMode = state.mode;
        //   langCode = state.langCode;
        // }
        final themeMode = state.mode;
        final langCode = state.langCode;
        return MaterialApp.router(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: Locale(langCode),
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: GetIt.I<AppRouter>().config(),
        );
      },
    );
  }
}
