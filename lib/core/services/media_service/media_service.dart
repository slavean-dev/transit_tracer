import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transit_tracer/core/services/media_service/abstract_media_service.dart';

class MediaService implements AbstractMediaService {
  MediaService({required ImagePicker picker, required ImageCropper cropper})
    : _picker = picker,
      _cropper = cropper;
  final ImageCropper _cropper;
  final ImagePicker _picker;

  @override
  Future<File?> pickFromeGalery(String title) async {
    final xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile == null) return null;
    return _cropCircle(xFile.path, title);
  }

  @override
  Future<File?> pickFromeCamera(String title) async {
    final xFile = await _picker.pickImage(source: ImageSource.camera);

    if (xFile == null) return null;
    return _cropCircle(xFile.path, title);
  }

  Future<File?> _cropCircle(String sourcePath, String title) async {
    final cropper = await _cropper.cropImage(
      sourcePath: sourcePath,
      compressQuality: 95,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.black87,
          toolbarWidgetColor: Colors.white,
          cropStyle: CropStyle.circle,
          toolbarTitle: title,
          hideBottomControls: true,
          lockAspectRatio: true,
          initAspectRatio: CropAspectRatioPreset.square,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        ),
        IOSUiSettings(
          title: title,
          aspectRatioLockEnabled: true,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        ),
      ],
    );
    if (cropper == null) return null;
    return File(cropper.path);
  }
}
