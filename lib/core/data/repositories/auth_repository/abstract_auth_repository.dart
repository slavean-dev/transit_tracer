import 'package:firebase_auth/firebase_auth.dart';
import 'package:transit_tracer/core/models/user_role/user_role.dart';

abstract class AbstractAuthRepository {
  Stream<User?> authStateChanges();
  User? get currentUser;

  Future<void> register({
    required String name,
    required String surname,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  });
  Future<void> login({required String login, required String password});
  Future<void> logout();
}
