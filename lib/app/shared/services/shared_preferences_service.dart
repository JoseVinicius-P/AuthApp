import 'package:auth/app/shared/interfaces/i_shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ISharedPreferencesService{
  @override
  late SharedPreferences prefs;

  @override
  void setRememberMe(bool rememberMe) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("remeberMe", rememberMe);
  }

  @override
  Future<bool> isRememberMe() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool("remeberMe") ?? false;
  }

  @override
  void setAlreadyAccessed(bool alreadyAccessed) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("alreadyAccessed", alreadyAccessed);
  }

  @override
  Future<bool> isAlreadyAccessed() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool("alreadyAccessed") ?? false;
  }
}