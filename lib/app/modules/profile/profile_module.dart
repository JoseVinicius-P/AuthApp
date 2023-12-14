import 'package:auth/app/modules/profile/interfaces/i_image_picker_service.dart';
import 'package:auth/app/modules/profile/interfaces/i_profile_store.dart';
import 'package:auth/app/modules/profile/services/user_data_guard_service.dart';
import 'package:auth/app/shared/services/auth_guard_service.dart';
import 'package:auth/app/modules/profile/pages/fill_profile_page.dart';
import 'package:auth/app/modules/profile/services/image_picker_service.dart';
import 'package:auth/app/modules/profile/stores/profile_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IImagePickerService>((i) => ImagePickerService()),
    Bind.lazySingleton<IProfileStore>((i) => ProfileStore(imagePickerService: i(), userDataService: i())),
    Bind.lazySingleton((i) => UserDataGuardService())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const FillProfilePage(), guards: [AuthGuardService(), UserDataGuardService()]),
  ];

}