import 'package:auth/app/modules/authentication/interfaces/i_auth_service.dart';
import 'package:auth/app/modules/authentication/interfaces/i_login_store.dart';
import 'package:auth/app/modules/authentication/interfaces/i_user_login_service.dart';
import 'package:auth/app/modules/authentication/stores/authentication_store.dart';
import 'package:auth/app/shared/interfaces/i_shared_preferences_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginStore extends AuthenticationStore implements Disposable, ILoginStore{

  LoginStore(
      ISharedPreferencesService sharedPreferencesService,
      IAuthService authService,
      IUserLoginService userLoginService
      ) : super(sharedPreferencesService, authService, userLoginService);

  @override
  void signInWithEmailAndPassword() async {
    setLoading(true);
    String? errorEmail = userLoginService.verifyEmail(state.email);
    if(errorEmail == null){
      String? errorPassword = userLoginService.verifyPassword(state.password);
      if(errorPassword == null){
        sharedPreferencesService.setRememberMe(state.rememberMe);
        await authService.signInWithEmailAndPassword(state.email, state.password, (error) => setError(error));
      }else{
        setError(errorPassword);
        setLoading(false);
      }
    }else{
      setError(errorEmail);
      setLoading(false);
    }
  }
}