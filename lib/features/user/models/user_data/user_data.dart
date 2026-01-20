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
      'uid': uid,
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phoneNumber,
      'password': password,
      'role': role.name,
      'createdAt': DateTime.now().toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] as String,
      surname: map['surname'] as String,
      email: map['email'] as String,
      phoneNumber: map['phone'] as String,
      password: map['password'] as String,
      role: UserRole.values.firstWhere((r) => r.name == map['role'] as String),
      uid: map['uid'] as String,
      imageUrl: map['imageUrl'] as String?,
    );
  }
}
