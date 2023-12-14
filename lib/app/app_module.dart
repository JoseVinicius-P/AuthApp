import 'package:auth/app/modules/home/home_module.dart';
import 'package:auth/app/shared/interfaces/i_global_auth_service.dart';
import 'package:auth/app/shared/interfaces/i_shared_preferences_service.dart';
import 'package:auth/app/shared/interfaces/i_user_data_service.dart';
import 'package:auth/app/shared/services/user_data_service.dart';
import 'package:auth/app/shared/services/global_auth_service.dart';
import 'package:auth/app/modules/authentication/authentication_module.dart';
import 'package:auth/app/shared/services/shared_preferences_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => FirebaseAuth.instance),
    Bind.lazySingleton((i) => FirebaseStorage.instance),
    Bind.lazySingleton((i) => FirebaseFirestore.instance),
    Bind.lazySingleton<ISharedPreferencesService>((i) => SharedPreferencesService()),
    Bind.singleton<IGlobalAuthService>((i) => GlobalAuthService(i(), i())),
    Bind.lazySingleton<IUserDataService>((i) => UserDataService( i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: AuthenticationModule()),
    ModuleRoute('/home', module: HomeModule())
  ];

}