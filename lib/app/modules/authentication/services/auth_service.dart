import 'dart:async';
import 'package:auth/app/modules/authentication/interfaces/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService implements IAuthService{

  @override
  late final FirebaseAuth auth;

  AuthService(this.auth);

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(String email, String password, Function(String) onError) async {
    try{
     return await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        onError("Senha muito fraca, tente outra!");
      } else if (e.code == 'email-already-in-use') {
        onError("Este email já está cadastrado!");
      }else{
        onError('Erro inesperado');
      }
      return null;
    } catch(e){
      onError("Erro inesperado!");
      return null;
    }
  }

  @override
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password, Function(String) onError) async {
    try{
      return await auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        onError("Email não cadastrado");
      } else if (e.code == 'wrong-password') {
        onError('Senha incorreta!');
      }else if (e.code == 'invalid-credential'){
        onError('Email ou senha incorretos');
      }else{
        onError('Email ou senha incorretos');
      }

      return null;
    } catch(e){
      onError("Erro inesperado!");
      return null;
    }
  }

  @override
  Future<bool> signInWithGoogle() async {
    try{
      if(kIsWeb){
        // Create a new provider
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({
          'login_hint': 'user@example.com'
        });

        UserCredential user = await FirebaseAuth.instance.signInWithPopup(googleProvider);

        // Once signed in, return the UserCredential
        return user.user != null;
      }else{
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);

        // Once signed in, return the UserCredential
        return user.user != null;
      }
    }catch(e){
      return false;
    }

  }
}