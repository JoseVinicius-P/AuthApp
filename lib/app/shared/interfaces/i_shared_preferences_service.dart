import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPreferencesService{
  late SharedPreferences prefs;

  void setRememberMe(bool rememberMe);
  Future<bool> isRememberMe();
  void setAlreadyAccessed(bool alreadyAccessed);
  Future<bool> isAlreadyAccessed();
}