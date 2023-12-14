import 'package:auth/app/shared/services/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';

abstract class IImagePickerService {

  Future<String> pickImage();
  Future<CroppedFile?> cropImage(String path, BuildContext context);
}