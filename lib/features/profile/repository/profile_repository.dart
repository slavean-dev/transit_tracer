import 'dart:io';

import 'package:transit_tracer/core/data/repositories/media_repository/abstract_media_repository.dart';
import 'package:transit_tracer/core/data/repositories/user_data_repository/abstract_user_data.dart';
import 'package:transit_tracer/features/profile/repository/abstract_profile_repository.dart';

class ProfileRepository implements AbstractProfileRepository {
  ProfileRepository({required this.media, required this.userData});

  final AbstractMediaRepository media;
  final AbstractUserDataRepository userData;

  @override
  Future<void> changeProfilePhoto({
    required String uid,
    required File file,
  }) async {
    final url = await media.uploadProfilePhoto(uid: uid, file: file);

    await userData.updateUserPhoto(uid: uid, url: url);
  }
}
