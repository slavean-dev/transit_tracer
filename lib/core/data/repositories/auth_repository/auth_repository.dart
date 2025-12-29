import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transit_tracer/features/auth/errors/auth_failure.dart';
import 'package:transit_tracer/features/auth/errors/firebase_auth_errors.dart';
import 'package:transit_tracer/core/models/user_data/user_data.dart';
import 'package:transit_tracer/core/models/user_role/user_role.dart';

import 'package:transit_tracer/core/data/repositories/auth_repository/abstract_auth_repository.dart';

class AuthRepository implements AbstractAuthRepository {
  AuthRepository({required this.auth, required this.firestore});
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  @override
  Stream<User?> authStateChanges() => auth.authStateChanges();

  @override
  User? get currentUser => auth.currentUser;

  @override
  Future<void> register({
    required String name,
    required String surname,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      final userData = UserData(
        name: name,
        surname: surname,
        email: email,
        phoneNumber: phone,
        password: password,
        role: role,
        uid: uid,
      );

      await firestore.collection('users').doc(uid).set(userData.toMap());
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(type: FirebaseAuthErrors.map(e.code));
    }
  }

  @override
  Future<void> login({required String login, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: login, password: password);
    } on FirebaseException catch (e) {
      throw AuthFailure(type: FirebaseAuthErrors.map(e.code));
    }
  }

  @override
  Future<void> logout() => auth.signOut();
}
