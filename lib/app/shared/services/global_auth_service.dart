import 'dart:async';

import 'package:auth/app/shared/interfaces/i_global_auth_service.dart';
import 'package:auth/app/shared/interfaces/i_shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GlobalAuthService extends Disposable implements IGlobalAuthService{
  @override
  late final FirebaseAuth auth;
  @override
  late StreamSubscription listener;
  @override
  late final ISharedPreferencesService sharedPreferencesService;

  @override
  void dispose() {
    listener.cancel();
  }

  GlobalAuthService(this.sharedPreferencesService, this.auth){
    listener = listenAuthStateChanges();
  }

  @override
  StreamSubscription listenAuthStateChanges() {
    return auth.authStateChanges()
        .listen((User? user) async {
      if(await isUserLoggedIn(user)){
        Modular.to.navigate('./profile/');
      }else{
        Modular.to.navigate('/');
      }
    });
  }

  @override
  Future<void> signOut() async {
    return await auth.signOut();
  }

  @override
  User? getUser(){
    return auth.currentUser;
  }

  @override
  FutureOr<bool> isUserLoggedIn(User? currentUser) async {
    if(currentUser == null){
      return false;
    }else{
      if(await sharedPreferencesService.isRememberMe()){
        return true;
      }else if(!await sharedPreferencesService.isAlreadyAccessed()){
        sharedPreferencesService.setAlreadyAccessed(true);
        return true;
      }else{
        auth.signOut();
        sharedPreferencesService.setAlreadyAccessed(false);
        return false;
      }
    }
  }
}