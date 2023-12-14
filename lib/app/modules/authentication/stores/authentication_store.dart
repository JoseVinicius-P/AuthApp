import 'dart:async';

import 'package:auth/app/modules/authentication/interfaces/i_auth_service.dart';
import 'package:auth/app/modules/authentication/interfaces/i_authentication_store.dart';
import 'package:auth/app/modules/authentication/interfaces/i_user_login_service.dart';
import 'package:auth/app/modules/authentication/models/user_login_model.dart';
import 'package:auth/app/shared/interfaces/i_shared_preferences_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AuthenticationStore extends Store<UserLoginModel> implements Disposable, IAuthenticationStore{
  @override
  late final IAuthService authService;
  @override
  late final IUserLoginService userLoginService;
  @override
  late final ISharedPreferencesService sharedPreferencesService;
  Timer? timer;

  AuthenticationStore(this.sharedPreferencesService, this.authService, this.userLoginService) : super(UserLoginModel('', '', true));

  @override
  void updateEmail(String email){
    update(UserLoginModel(email, state.password, state.rememberMe));
  }

  @override
  void updatePassword(String password){
    update(UserLoginModel(state.email, password, state.rememberMe));
  }

  @override
  void updateRememberMe(bool rememberMe){
    update(UserLoginModel(state.email, state.password, rememberMe));
  }

  @override
  void signInWithGoogle() async {
    setLoading(true);
    if(await authService.signInWithGoogle()){
      sharedPreferencesService.setRememberMe(state.rememberMe);
      setLoading(false);
    }else{
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