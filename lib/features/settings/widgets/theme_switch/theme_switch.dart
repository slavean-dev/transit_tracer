import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/generated/l10n.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key, required this.theme, required this.isDark});

  final ThemeData theme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      theme: theme,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S.of(context).darkThemeSwith),
          Switch(
            activeThumbColor: theme.primaryColor,
            activeTrackColor: theme.colorScheme.surfaceContainer,
            inactiveTrackColor: theme.colorScheme.surfaceContainer,
            inactiveThumbColor: theme.colorScheme.surface,
            value: isDark,
            onChanged: (_) => context.read<SettingsCubit>().toggleDarkLight(),
          ),
        ],
      ),
    );
  }
}
