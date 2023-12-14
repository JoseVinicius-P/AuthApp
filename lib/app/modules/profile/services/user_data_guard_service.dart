import 'dart:async';

import 'package:auth/app/shared/interfaces/i_user_data_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserDataGuardService extends RouteGuard{

  UserDataGuardService() : super(redirectTo: '/home/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    //se este metodo retornar true a rota pode ser acessada se não será redirecionada
    return !await Modular.get<IUserDataService>().isDataComplete();
  }



}