import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  late final FirebaseAuth auth;

  Future<UserCredential?> createUserWithEmailAndPassword(String email, String password, Function(String) onError);
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password, Function(String) onError);
  Future<bool> signInWithGoogle();

}