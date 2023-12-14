import 'package:auth/app/modules/authentication/interfaces/i_user_login_service.dart';

class UserLoginService implements IUserLoginService{

  @override
  String? verifyEmail(String? email){
    if(email == null || email.isEmpty){
      return "Forneça um email";
    }else if(!email.contains('@')){
      return "Email não existe";
    }else{
      return null;
    }
  }

  @override
  String? verifyPassword(String? password){
    if(password == null || password.isEmpty){
      return "Forneça uma senha";
    }else if(password.length < 6){
      return "A senha deve ter mais de 6 caracteres";
    }else{
      return null;
    }
  }

}