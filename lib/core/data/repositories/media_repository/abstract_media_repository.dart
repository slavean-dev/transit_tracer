import 'dart:io';

abstract class AbstractMediaRepository {
  Future<String> uploadProfilePhoto({required String uid, required File file});
}
