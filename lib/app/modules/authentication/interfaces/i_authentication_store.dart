import 'dart:async';

import 'package:auth/app/modules/authentication/interfaces/i_auth_service.dart';
import 'package:auth/app/modules/authentication/interfaces/i_user_login_service.dart';
import 'package:auth/app/modules/authentication/models/user_login_model.dart';
import 'package:auth/app/shared/interfaces/i_shared_preferences_service.dart';
import 'package:flutter_triple/flutter_triple.dart';

abstract class IAuthenticationStore extends Store<UserLoginModel>{
  late final IAuthService authService;
  late final IUserLoginService userLoginService;
  late final ISharedPreferencesService sharedPreferencesService;

  IAuthenticationStore(super.initialState);

  void updateEmail(String email);
  void updatePassword(String password);
  void updateRememberMe(bool rememberMe);
  void signInWithGoogle();
}