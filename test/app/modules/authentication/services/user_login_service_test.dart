import 'package:flutter_test/flutter_test.dart';
import 'package:auth/app/modules/authentication/services/user_login_service.dart';
 
void main() {
  late UserLoginService service;

  setUpAll(() {
    service = UserLoginService();
  });
}