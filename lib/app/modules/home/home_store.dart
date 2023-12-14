import 'package:auth/app/modules/home/i_home_store.dart';
import 'package:auth/app/shared/interfaces/i_global_auth_service.dart';
import 'package:auth/app/shared/interfaces/i_user_data_service.dart';
import 'package:auth/app/shared/models/profile_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomeStore extends Store<ProfileModel> implements IHomeStore{
  @override
  late final IGlobalAuthService globalAuthService;
  @override
  late final IUserDataService userDataService;

  HomeStore(this.globalAuthService, this.userDataService) : super(ProfileModel('', '', ''));

  @override
  void singOut() async {
    setLoading(true);
    globalAuthService.signOut().then((value){
      Modular.to.navigate('/');
      setLoading(false);
    });
  }

  @override
  void loadUserData() async {
    setLoading(true);
    update(ProfileModel.fromDocumentSnapshot(await userDataService.getUserData()));
    setLoading(false);
  }

}