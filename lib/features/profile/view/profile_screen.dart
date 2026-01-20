import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recase/recase.dart';
import 'package:transit_tracer/features/user/bloc/app_user_bloc.dart';
import 'package:transit_tracer/features/user/models/app_user_state/app_user_status.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/features/profile/cubit/profile_cubit.dart';
import 'package:transit_tracer/features/profile/widgets/contact_info_container/contact_info_container.dart';
import 'package:transit_tracer/features/profile/widgets/personal_info_container/personal_info_container.dart';
import 'package:transit_tracer/features/profile/widgets/profile_avatar/profile_avatar.dart';
import 'package:transit_tracer/features/profile/widgets/profile_popup_menu/profile_popup_menu.dart';
import 'package:transit_tracer/generated/l10n.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppUserBloc>().add(AppUserStarted());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => GetIt.I<ProfileCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).profileTitle,
            style: theme.textTheme.headlineLarge,
          ),
          actions: [ProfilePopupMenu(theme: theme)],
        ),
        body: BlocBuilder<AppUserBloc, AppUserState>(
          builder: (context, state) {
            switch (state.status) {
              case AppUserStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case AppUserStatus.failure:
                return Center(
                  child: Text(state.errorMassage ?? 'Failed to load user data'),
                );
              case AppUserStatus.unauthorized:
                return const Center(child: Text('Not authorized'));
              case AppUserStatus.authorized:
                final userData = state.user!;
                return BlocListener<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is ChangeAvatarCoplete) {
                      context.read<AppUserBloc>().add(AppUserReloadRequested());
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 18,
                        right: 18,
                      ),
                      child: Column(
                        children: [
                          ProfileAvatar(
                            theme: theme,
                            uid: userData.uid,
                            imageUrl: userData.imageUrl,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${userData.name} ${userData.surname}'.titleCase,
                            style: theme.textTheme.titleLarge,
                          ),
                          BaseContainer(
                            theme: theme,
                            child: Text(
                              userData.role.name.sentenceCase,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(height: 20),
                          ContactInfoContainer(
                            theme: theme,
                            userData: userData,
                          ),
                          SizedBox(height: 20),
                          PersonalInfoContainer(theme: theme),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
