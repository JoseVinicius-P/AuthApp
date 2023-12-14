import 'package:auth/app/modules/home/i_home_store.dart';
import 'package:auth/app/shared/models/profile_model.dart';
import 'package:auth/app/shared/services/my_colors.dart';
import 'package:auth/app/shared/widgets/avatar_widget.dart';
import 'package:auth/app/shared/services/my_edge_insets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final IHomeStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var avatar = SizedBox(
      height: 40.sw,
      width: 40.sw,
      child: TripleBuilder(
          store: store,
          builder: (context, triple) {
            ProfileModel profileModel = triple.state as ProfileModel;
            return Opacity(
              opacity: profileModel.fullName.isEmpty ? 0 : 1,
              child: AvatarWidget(
                placeholder: const AssetImage('assets/images/profile.png'),
                avatarImageProvider: profileModel.profilePictureUrl.isNotEmpty ? NetworkImage(profileModel.profilePictureUrl) : null,
                showButton: false,
              ),
            );
          }
      ),
    );

    var text = TripleBuilder(
      store: store,
      builder: (context, triple) {
        ProfileModel profileModel = triple.state as ProfileModel;
        return Opacity(
          opacity: profileModel.fullName.isEmpty ? 0 : 1,
          child: AutoSizeText(
            "Seja bem vindo(a) ${profileModel.fullName}! Obrigado por usar o AuthApp.",
            style: theme.textTheme.titleLarge!.copyWith(fontSize: 25, color: MyColors.textColor, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
            maxFontSize: 80,
            maxLines: 3,
          ),
        );
      }
    );

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(11)
                ),
                padding: const EdgeInsets.all(3),
                child: const Icon(Icons.admin_panel_settings_rounded, color: Colors.white, size: 25,)
            ),
            const SizedBox(width: 8,),
            Text(
              "AuthApp",
              style: theme.textTheme.titleMedium!.copyWith(color: MyColors.textColor, fontSize: 22),
            ),
          ],
        ),
        actions: [
          TripleBuilder(
            store: store,
            builder: (context, triple) {
              return IconButton(
                icon: Icon(Icons.exit_to_app_rounded, color: triple.isLoading ? Colors.grey : MyColors.primaryColor,),
                onPressed: () => store.singOut(),
              );
            }
          )
        ]
      ),
      body: Padding(
        padding: MyEdgeInsets.standard.copyWith(top: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    avatar,
                    const SizedBox(height: 15),
                    text
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}