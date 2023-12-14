import 'package:auth/app/modules/home/home_page.dart';
import 'package:auth/app/modules/home/home_store.dart';
import 'package:auth/app/modules/home/i_home_store.dart';
import 'package:auth/app/shared/services/auth_guard_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IHomeStore>((i) => HomeStore(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage(), guards: [AuthGuardService()]),
  ];

}