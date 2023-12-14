import 'package:auth/app/modules/authentication/interfaces/i_auth_service.dart';
import 'package:auth/app/modules/authentication/interfaces/i_authentication_store.dart';
import 'package:auth/app/modules/authentication/interfaces/i_user_login_service.dart';
import 'package:auth/app/modules/authentication/services/auth_service.dart';
import 'package:auth/app/modules/authentication/stores/authentication_store.dart';
import 'package:auth/app/shared/services/shared_preferences_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class ICreateAccountStore extends IAuthenticationStore{
  ICreateAccountStore(super.initialState);

  void createAccount();
  @override
  void signInWithGoogle();
  @override
  void updateEmail(String email);
  @override
  void updatePassword(String password);
  @override
  void updateRememberMe(bool rememberMe);
}