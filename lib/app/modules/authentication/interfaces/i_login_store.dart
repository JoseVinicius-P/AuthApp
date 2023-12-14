import 'package:auth/app/modules/authentication/interfaces/i_authentication_store.dart';

abstract class ILoginStore extends IAuthenticationStore{

  ILoginStore(super.initialState);

  void signInWithEmailAndPassword();
  @override
  void signInWithGoogle();
  @override
  void updateEmail(String email);
  @override
  void updatePassword(String password);
  @override
  void updateRememberMe(bool rememberMe);
}