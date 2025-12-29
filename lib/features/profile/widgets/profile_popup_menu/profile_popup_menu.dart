import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/bloc/app_user_bloc.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/generated/l10n.dart';

class ProfilePopupMenu extends StatelessWidget {
  const ProfilePopupMenu({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_horiz),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: Row(
            children: [
              const Icon(Icons.edit),
              SizedBox(width: 10),
              Text(
                S.of(context).editProfileDropMenu,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          onTap: () {
            context.router.push(const SettingsRoute());
          },
          child: Row(
            children: [
              const Icon(Icons.settings),
              SizedBox(width: 10),
              Text(S.of(context).settings, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            context.router.push(const AboutUsRoute());
          },
          child: Row(
            children: [
              const Icon(Icons.menu),
              SizedBox(width: 10),
              Text(S.of(context).aboutUsTitle),
            ],
          ),
        ),
        PopupMenuItem<String>(
          onTap: () {
            context.read<AppUserBloc>().add(AppUserLogoutRequest());
          },
          child: Row(
            children: [
              const Icon(Icons.logout),
              SizedBox(width: 10),
              Text(S.of(context).logout),
            ],
          ),
        ),
      ],
    );
  }
}
