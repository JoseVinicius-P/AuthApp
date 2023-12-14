import 'package:auth/app/modules/authentication/interfaces/i_auth_service.dart';
import 'package:auth/app/modules/authentication/interfaces/i_create_account_store.dart';
import 'package:auth/app/modules/authentication/interfaces/i_login_store.dart';
import 'package:auth/app/modules/authentication/interfaces/i_user_login_service.dart';
import 'package:auth/app/modules/authentication/services/user_login_service.dart';
import 'package:auth/app/modules/authentication/services/auth_service.dart';
import 'package:auth/app/modules/authentication/stores/create_account_store.dart';
import 'package:auth/app/modules/authentication/pages/create_account_page.dart';
import 'package:auth/app/modules/authentication/pages/login_page.dart';
import 'package:auth/app/modules/authentication/pages/presentation_page.dart';
import 'package:auth/app/modules/authentication/stores/login_store.dart';
import 'package:auth/app/modules/authentication/services/auth_guard_service.dart';
import 'package:auth/app/modules/profile/profile_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthenticationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IUserLoginService>((i) => UserLoginService()),
    Bind.lazySingleton<IAuthService>((i) => AuthService(i())),
    Bind.lazySingleton<ICreateAccountStore>((i) => CreateAccountStore(i(), i(), i())),
    Bind.lazySingleton<ILoginStore>((i) => LoginStore(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const PresentationPage(), guards: [AuthGuardService()]),
    ChildRoute('/login', child: (_, args) => const LoginPage(), guards: [AuthGuardService()]),
    ChildRoute('/create_account', child: (_, args) => const CreateAccountPage(), guards: [AuthGuardService()]),
    ModuleRoute('/profile', module: ProfileModule())
  ];

}