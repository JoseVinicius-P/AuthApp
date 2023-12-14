import 'dart:async';
import 'dart:io';
import 'package:auth/app/modules/profile/interfaces/i_profile_store.dart';
import 'package:auth/app/shared/models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:auth/app/shared/widgets/avatar_widget.dart';
import 'package:auth/app/shared/widgets/text_field_widget.dart';
import 'package:auth/app/shared/services/my_colors.dart';
import 'package:auth/app/shared/services/my_edge_insets.dart';
import 'package:auth/app/shared/widgets/default_button_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FillProfilePage extends StatefulWidget {
  const FillProfilePage({Key? key}) : super(key: key);
  @override
  FillProfilePageState createState() => FillProfilePageState();
}
class FillProfilePageState extends State<FillProfilePage> {
  final store = Modular.get<IProfileStore>();
  final _scrollController = ScrollController();
  late StreamSubscription<bool> keyboardSubscription;
  FocusNode focusNodeTextFieldPhoneNumber = FocusNode();

  @override
  void initState() {
    super.initState();
    listenKeyboard();
  }

  void listenKeyboard(){
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if(visible){
        _scrollController.jumpTo(_scrollController.position.extentTotal);
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    focusNodeTextFieldPhoneNumber.dispose();
    super.dispose();
  }

  ImageProvider imageProvider(String path){
    if (kIsWeb) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textFieldFullName = TripleBuilder(
      store: store,
      builder: (context, triple) {
        return TextFieldWidget(
          hint: "Nome completo",
          keyboardType: TextInputType.text,
          prefixIcon: Icons.person_rounded,
          textInputAction: TextInputAction.next,
          onChanged: (fullName) => store.updateFullName(fullName),
          onFieldSubmitted: (_){
            FocusScope.of(context).requestFocus(focusNodeTextFieldPhoneNumber);
          },
          error: triple.error != null && triple.error!.isNotEmpty ? ' ': null,
          enable: !triple.isLoading,
        );
      }
    );
    var textFieldPhoneNumber = TripleBuilder(
      store: store,
      builder: (context, triple) {
        return TextFieldWidget(
          hint: "Telefone",
          prefixIcon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          focusNode: focusNodeTextFieldPhoneNumber,
          onChanged: (phoneNumber) => store.updatePhoneNumber(store.phoneMaskFormatter.getUnmaskedText()),
          maskFormatter: store.phoneMaskFormatter,
          error: triple.error,
          enable: !triple.isLoading,
        );
      }
    );
    var buttonNext = TripleBuilder(
      store: store,
      builder: (context, triple) {
        return DefaultButtonWidget(
          onTap: triple.isLoading ? null : () => store.saveUserData(),
          text: triple.isLoading ? "Salvando..." : "Continuar",
          backgroundColor: MyColors.primaryColor,
          textColor: MyColors.textButtonColor,
          shadow: false,
        );
      }
    );
    var avatarImage = SizedBox(
      width: 40.sw,
      height: 40.sw,
      child: TripleBuilder(
        store: store,
        builder: (context, triple) {
          String path = (triple.state as ProfileModel).profilePictureUrl.toString();
          return AvatarWidget(
            placeholder: const AssetImage('assets/images/profile.png'),
            avatarImageProvider: path.isNotEmpty ? imageProvider(path) : null,
            onTapSelectPhoto: triple.isLoading ? null : () => store.pickImage(context),
          );
        }
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () => SystemNavigator.pop(),
          icon: const Icon(Icons.close_rounded, color: MyColors.textColor,),
        ),
        title: Text(
          "Complete seu perfil",
          style: theme.textTheme.titleMedium!.copyWith(color: MyColors.textColor, fontSize: 25),
        ),
      ),
      body: OrientationLayoutBuilder(
        portrait: (context) {
          focusNodeTextFieldPhoneNumber = FocusNode();
          return SafeArea(
            child: Padding(
              padding: MyEdgeInsets.standard,
              child: Stack(
                children: [
                  Scaffold(
                    resizeToAvoidBottomInset: true,
                    body: SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom/2,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 5,),
                          Center(
                            child: avatarImage,
                          ),
                          const SizedBox(height: 25,),
                          textFieldFullName,
                          textFieldPhoneNumber,
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buttonNext
                    ],
                  )
                ],
              ),
            ),
          );
        },
        landscape: (context) {
          focusNodeTextFieldPhoneNumber = FocusNode();
          return SafeArea(
            child: Center(
              child: SizedBox(
                width: 100.sw,
                child: Padding(
                  padding: MyEdgeInsets.standard.copyWith(top: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 5,),
                        Center(
                          child: avatarImage,
                        ),
                        const SizedBox(height: 25,),
                        textFieldFullName,
                        textFieldPhoneNumber,
                        const SizedBox(height: 25,),
                        buttonNext,
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}