import 'package:auth/app/shared/interfaces/i_global_auth_service.dart';
import 'package:auth/app/shared/interfaces/i_user_data_service.dart';
import 'package:auth/app/shared/models/profile_model.dart';
import 'package:flutter_triple/flutter_triple.dart';

abstract class IHomeStore extends Store<ProfileModel> {
  late final IGlobalAuthService globalAuthService;
  late final IUserDataService userDataService;

  IHomeStore(super.initialState);

  void singOut();
  void loadUserData();
}