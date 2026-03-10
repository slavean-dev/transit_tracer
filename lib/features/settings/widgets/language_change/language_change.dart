import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/constants/app_constants.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/generated/l10n.dart';

class LanguageChange extends StatelessWidget {
  const LanguageChange({
    super.key,
    required this.theme,
    required this.langCode,
  });

  final ThemeData theme;
  final String langCode;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S.of(context).languageDropMenu),
          DropdownButton(
            value: langCode,
            items: AppConfig.supportedLanguages.map((lang) {
              return DropdownMenuItem(
                value: lang.code,
                child: Text(lang.name, style: theme.textTheme.bodyMedium),
              );
            }).toList(),
            onChanged: (value) {
              context.read<SettingsCubit>().setLangCode(value!);
            },
          ),
        ],
      ),
    );
  }
}
