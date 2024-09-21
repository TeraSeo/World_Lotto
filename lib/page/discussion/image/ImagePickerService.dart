import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {

  static final ImagePickerService _instance = ImagePickerService._internal();

  ImagePickerService._internal();

  static ImagePickerService get instance => _instance;

  Future<List<XFile>?> pickCropImage({
    required CropAspectRatio cropAspectRatio,
    required ImageSource imageSource,
    required BuildContext context
  }) async {
    try {
      if (!await Permission.photos.request().isGranted && !await Permission.storage.request().isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('photoPermission'.tr()),
          )
        );
        return null;
      }
      List<XFile>? pickImages = await ImagePicker().pickMultiImage(imageQuality: 90, limit: 8);
      if (pickImages.length == 0) return null;

      List<XFile> croppedFiles = [];
      for (int i = 0; i < pickImages.length; i++) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickImages[i].path,
          aspectRatio: cropAspectRatio,
          compressQuality: 90,
          compressFormat: ImageCompressFormat.jpg
        );
        croppedFiles.add(XFile(croppedFile!.path));
      }
      if (croppedFiles.length == 0) return null;

      return croppedFiles;
    } catch(e) {
      return null;
    }
  }
}