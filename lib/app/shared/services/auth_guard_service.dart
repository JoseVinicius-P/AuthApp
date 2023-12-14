import 'dart:async';

import 'package:auth/app/shared/interfaces/i_global_auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuardService extends RouteGuard{

  AuthGuardService() : super(redirectTo: '/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    //se este metodo retornar true a rota pode ser acessada se não será redirecionada
    var globalAuthService = Modular.get<IGlobalAuthService>();
    return await globalAuthService.isUserLoggedIn(globalAuthService.getUser());
  }



}