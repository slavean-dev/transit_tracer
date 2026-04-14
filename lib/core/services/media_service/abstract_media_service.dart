import 'dart:io';

abstract class AbstractMediaService {
  Future<File?> pickFromeGalery(String title);
  Future<File?> pickFromeCamera(String title);
}
