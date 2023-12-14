import 'package:auth/app/modules/profile/interfaces/i_image_picker_service.dart';
import 'package:auth/app/shared/services/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ImagePickerService implements IImagePickerService{

  @override
  Future<String> pickImage() async {
    final XFile? pickedImage;
    ImagePicker picker = ImagePicker();
    try{
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
      return pickedImage!.path;
    }catch(e, stackTrace){
      print('ERRO: $e, $stackTrace');
      return "";
    }
  }

  @override
  Future<CroppedFile?> cropImage(String path, BuildContext context) async {
      return ImageCropper().cropImage(
        sourcePath: path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            backgroundColor: Colors.white,
            toolbarTitle: 'Cortar',
            toolbarColor: Colors.white,
            toolbarWidgetColor: MyColors.primaryColor,
            activeControlsWidgetColor: MyColors.textColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            dimmedLayerColor: Colors.black.withOpacity(0.1),
            statusBarColor: MyColors.primaryColor,
            cropFrameColor: Colors.white,
          ),
          WebUiSettings(
            context: context,
            enableResize: false,
            enableOrientation: true,
            showZoomer: true,
            boundary: CroppieBoundary(height: 50.sw.round()),
            enableZoom: true,
            viewPort: CroppieViewPort(height: 50.sw.round(), width: 50.sw.round()),
            mouseWheelZoom: true,
          ),
        ],
      );
  }
}