import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:transit_tracer/features/profile/cubit/profile_cubit.dart';
import 'package:transit_tracer/features/profile/widgets/modal_sheet_list_tile/modal_sheet_list_tile.dart';
import 'package:transit_tracer/generated/l10n.dart';
import 'package:transit_tracer/core/services/media_service/media_service.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key, required this.theme, required this.uid});

  final ThemeData theme;
  final String uid;
  @override
  Widget build(BuildContext context) {
    final MediaService picker = GetIt.I<MediaService>();
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),

      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ModalSheetListTile(
              theme: theme,
              title: S.of(context).uploadPhotoFromGalery,
              onTap: () async {
                final file = await picker.pickFromeGalery(S.of(context).avatar);
                if (context.mounted) {
                  if (file != null) {
                    context.read<ProfileCubit>().upLoadUserImage(uid, file);
                  }
                  Navigator.pop(context);
                }
              },
            ),
            Divider(),
            ModalSheetListTile(
              theme: theme,
              title: S.of(context).takePhotoFromCamera,
              onTap: () async {
                final file = await picker.pickFromeCamera(S.of(context).avatar);
                if (context.mounted) {
                  if (file != null) {
                    context.read<ProfileCubit>().upLoadUserImage(uid, file);
                  }
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
