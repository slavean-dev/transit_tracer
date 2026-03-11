import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:transit_tracer/core/constants/firebase_constants.dart';
import 'package:transit_tracer/core/data/repositories/media_repository/abstract_media_repository.dart';

class FirebaseMediaRepository implements AbstractMediaRepository {
  FirebaseMediaRepository({required FirebaseStorage firebaseStorage})
    : _firebaseStorage = firebaseStorage;
  final FirebaseStorage _firebaseStorage;

  @override
  Future<String> uploadProfilePhoto({
    required String uid,
    required File file,
  }) async {
    final path =
        '${StoragePath.usersAvatar}/$uid/${StoragePath.avatarFileName}';
    final storageRef = _firebaseStorage.ref().child(path);
    await storageRef.putFile(file);

    final url = await storageRef.getDownloadURL();
    return url;
  }
}
