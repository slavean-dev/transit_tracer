import 'package:transit_tracer/core/models/user_data/user_data.dart';

abstract class AbstractUserDataRepository {
  Future<UserData> loadUserData(
    //{required String uid}
  );
  Future<void> updateUserPhoto({required String uid, required String url});
}
