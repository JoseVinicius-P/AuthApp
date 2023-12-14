import 'package:auth/app/shared/services/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AuthApp',
      theme: ThemeData(
        splashFactory: InkRipple.splashFactory,
        splashColor: Colors.black.withOpacity(0.1),
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),
        scaffoldBackgroundColor: MyColors.backgroundColor,
        useMaterial3: true,
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 40, color: Colors.white),
          titleLarge: TextStyle(fontSize: 70, color: MyColors.primaryColor, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}