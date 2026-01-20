import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transit_tracer/features/user/user_data_repository/abstract_user_data.dart';
import 'package:transit_tracer/features/user/models/user_data/user_data.dart';

class UserDataRepository implements AbstractUserDataRepository {
  UserDataRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<UserData> loadUserData() async {
    final currentUser = _firebaseAuth.currentUser;
    final doc = await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    return UserData.fromMap(doc.data()!);
  }

  @override
  Future<void> updateUserPhoto({
    required String uid,
    required String url,
  }) async {
    await _firebaseFirestore.collection('users').doc(uid).update({
      'imageUrl': url,
    });
  }
}
