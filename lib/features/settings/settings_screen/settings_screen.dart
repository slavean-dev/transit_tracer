import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/features/settings/widgets/language_change/language_change.dart';
import 'package:transit_tracer/features/settings/widgets/theme_switch/theme_switch.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).settings)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            // late final bool isDark;
            // late final String langCode;
            // if (state is SettingsDataLoaded) {
            //   isDark = state.mode == ThemeMode.dark;
            //   langCode = state.langCode;
            // }
            final isDark = state.mode == ThemeMode.dark;
            final langCode = state.langCode;
            return Column(
              children: [
                ThemeSwitch(theme: theme, isDark: isDark),
                const SizedBox(height: 16),
                LanguageChange(theme: theme, langCode: langCode),
              ],
            );
          },
        ),
      ),
    );
  }
}
