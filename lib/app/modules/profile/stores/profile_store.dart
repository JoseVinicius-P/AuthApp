import 'dart:async';

import 'package:auth/app/modules/profile/interfaces/i_image_picker_service.dart';
import 'package:auth/app/modules/profile/interfaces/i_profile_store.dart';
import 'package:auth/app/shared/interfaces/i_user_data_service.dart';
import 'package:auth/app/shared/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileStore extends Store<ProfileModel> implements Disposable, IProfileStore{
  @override
  late final IImagePickerService imagePickerService;
  @override
  late final MaskTextInputFormatter phoneMaskFormatter;
  Timer? timer;
  @override
  late final IUserDataService userDataService;

  ProfileStore({required this.imagePickerService, required this.userDataService}) : super(ProfileModel('', '', '')){
    phoneMaskFormatter = MaskTextInputFormatter(
        mask: '(##) # ####-####',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );
  }

  @override
  void updateProfilePicture(String profilePictureUrl){
    update(ProfileModel(profilePictureUrl, state.fullName, state.phoneNumber));
  }

  @override
  void updateFullName(String fullName){
    update(ProfileModel(state.profilePictureUrl, fullName, state.phoneNumber));
  }

  @override
  void updatePhoneNumber(String phoneNumber){
    update(ProfileModel(state.profilePictureUrl, state.fullName, phoneNumber));
  }

  @override
  void pickImage(BuildContext context) async{
    setLoading(true);
    final localContext = context;
    String path = await imagePickerService.pickImage();
    if(path.isNotEmpty){
      CroppedFile? croppedFile = await imagePickerService.cropImage(path, localContext);
      updateProfilePicture(croppedFile?.path ?? "");
    }
    setLoading(false);
  }

  @override
  void saveUserData() async {
    setLoading(true);
    if(state.fullName.isEmpty){
      setError("Preencha o seu nome");
      setLoading(false);
    }else if(state.phoneNumber.length < 11){
      setError("Numero de telefone ínvalido");
      setLoading(false);
    }else{
      String urlPicture = await userDataService.saveProfilePicture(state.profilePictureUrl);
      if(!await userDataService.saveUserData(ProfileModel(urlPicture, state.fullName, state.phoneNumber))){
        setError("Não conseguimos salvar o seus dados, tente novamente!");
        setLoading(false);
      }else{
        Modular.to.navigate('/home/');
      }
      setLoading(false);
    }
  }

  @override
  void dispose() {
    if(timer != null) {
      timer!.cancel();
      setError("");
    }
  }

  @override
  void setError(newError, {bool force = false}) {
    super.setError(newError);
    if(newError != null){
      initTimer();
    }
  }

  void initTimer(){
    if(timer != null) {
      timer!.cancel();
    }
    timer = Timer(const Duration(seconds: 3), () {
      setError("");
      setError(null);
    });
  }


}