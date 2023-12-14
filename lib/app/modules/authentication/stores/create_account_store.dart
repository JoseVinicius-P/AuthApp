import 'package:auth/app/modules/authentication/interfaces/i_auth_service.dart';
import 'package:auth/app/modules/authentication/interfaces/i_create_account_store.dart';
import 'package:auth/app/modules/authentication/interfaces/i_user_login_service.dart';
import 'package:auth/app/modules/authentication/stores/authentication_store.dart';
import 'package:auth/app/shared/interfaces/i_shared_preferences_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateAccountStore extends AuthenticationStore implements Disposable, ICreateAccountStore{

  CreateAccountStore(
      ISharedPreferencesService sharedPreferencesService,
      IAuthService authService,
      IUserLoginService userLoginService
      ) : super(sharedPreferencesService, authService, userLoginService);

  @override
  void createAccount() async {
    setLoading(true);
    String? errorEmail = userLoginService.verifyEmail(state.email);
    if(errorEmail == null){
      String? errorPassword = userLoginService.verifyPassword(state.password);
      if(errorPassword == null){
        await authService.createUserWithEmailAndPassword(state.email, state.password, (error) => setError(error));
        if(error == null || (error as String).isEmpty){
          sharedPreferencesService.setRememberMe(state.rememberMe);
        }
      }else{
        setError(errorPassword);
      }
      setLoading(false);
    }else{
      setError(errorEmail);
      setLoading(false);
    }
  }
}