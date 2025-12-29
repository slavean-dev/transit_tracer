import 'dart:io';

abstract class AbstractProfileRepository {
  Future<void> changeProfilePhoto({required String uid, required File file});
}
