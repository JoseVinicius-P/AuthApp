import 'dart:async';

import 'package:auth/app/shared/interfaces/i_shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IGlobalAuthService{
  late final FirebaseAuth auth;
  late StreamSubscription listener;
  late final ISharedPreferencesService sharedPreferencesService;

  StreamSubscription listenAuthStateChanges();
  Future<void> signOut();
  User? getUser();
  FutureOr<bool> isUserLoggedIn(User? currentUser);
}