import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/profile/cubit/profile_cubit.dart';
import 'package:transit_tracer/features/profile/widgets/modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.theme,
    required this.uid,
    required this.imageUrl,
  });

  final String? imageUrl;
  final ThemeData theme;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 88,
          backgroundColor: theme.colorScheme.surface,
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ChangeAvatarLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return imageUrl != null
                  ? ClipOval(child: Image.network(imageUrl!))
                  : const Icon(
                      Icons.person,
                      size: 175,
                      color: Color.fromARGB(255, 134, 173, 241),
                    );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: GestureDetector(
            onTap: () {
              final cubitContext = context.read<ProfileCubit>();
              showModalBottomSheet(
                useRootNavigator: true,
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                    value: cubitContext,
                    child: ModalBottomSheet(theme: theme, uid: uid),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.all(6),
              child: Center(
                child: Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: theme.colorScheme.surface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
