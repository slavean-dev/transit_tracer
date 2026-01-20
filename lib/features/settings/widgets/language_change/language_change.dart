import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      theme: theme,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S.of(context).languageDropMenu),
          DropdownButton(
            value: langCode,
            items: [
              DropdownMenuItem(
                value: 'uk',
                child: Text(
                  S.of(context).dropMenuItemUkr,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              DropdownMenuItem(
                value: 'en',
                child: Text(
                  S.of(context).dropMenuItemEng,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              DropdownMenuItem(
                value: 'it',
                child: Text(
                  S.of(context).dropMenuItemIt,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
            onChanged: (value) {
              context.read<SettingsCubit>().setLangCode(value!);
            },
          ),
        ],
      ),
    );
  }
}
