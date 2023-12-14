import 'package:auth/app/modules/profile/interfaces/i_image_picker_service.dart';
import 'package:auth/app/shared/interfaces/i_user_data_service.dart';
import 'package:auth/app/shared/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class IProfileStore extends Store<ProfileModel>{
  late final IImagePickerService imagePickerService;
  late final MaskTextInputFormatter phoneMaskFormatter;
  late final IUserDataService userDataService;

  IProfileStore(super.initialState);

  void updateProfilePicture(String profilePictureUrl);
  void updateFullName(String fullName);
  void updatePhoneNumber(String phoneNumber);
  void pickImage(BuildContext context);
  void saveUserData();


}