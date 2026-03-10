import 'package:transit_tracer/core/constants/firebase_constants.dart';
import 'package:transit_tracer/features/user/models/user_role/user_role.dart';

class UserData {
  UserData({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.role,
    required this.uid,
    this.imageUrl,
  });

  final String uid;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String password;
  final UserRole role;
  final String? imageUrl;

  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.uid: uid,
      FirebaseConstants.name: name,
      FirebaseConstants.surname: surname,
      FirebaseConstants.email: email,
      FirebaseConstants.phone: phoneNumber,
      FirebaseConstants.password: password,
      FirebaseConstants.role: role.name,
      FirebaseConstants.createdAt: DateTime.now().toIso8601String(),
      FirebaseConstants.imageUrl: imageUrl,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map[FirebaseConstants.name] as String,
      surname: map[FirebaseConstants.surname] as String,
      email: map[FirebaseConstants.email] as String,
      phoneNumber: map[FirebaseConstants.phone] as String,
      password: map[FirebaseConstants.password] as String,
      role: UserRole.values.firstWhere(
        (r) => r.name == map[FirebaseConstants.role] as String,
      ),
      uid: map[FirebaseConstants.uid] as String,
      imageUrl: map[FirebaseConstants.imageUrl] as String?,
    );
  }
}
