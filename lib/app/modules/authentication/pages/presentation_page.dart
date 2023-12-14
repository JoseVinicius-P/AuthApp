import 'package:flutter/material.dart';
import 'package:auth/app/modules/authentication/widgets/animated_background_widget.dart';
import 'package:auth/app/modules/authentication/widgets/gradiend_background_widget.dart';
import 'package:auth/app/modules/authentication/widgets/welcome_widget.dart';
import 'package:auth/app/shared/widgets/flexible_sized_box.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({Key? key}) : super(key: key);
  @override
  PresentationPageState createState() => PresentationPageState();
}

class PresentationPageState extends State<PresentationPage>{

  void redirectToLogin(){
    Modular.to.pushNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (context) => Scaffold(
        body: AnimatedBackgroundWidget(
          image: const Image(
            image: AssetImage('assets/images/presentation_background.jpg'),
            fit: BoxFit.cover,
          ),
          child: Column(
            children: [
              const Spacer(),
              GradiendBackgroundWidget(
                  child: Column(
                    children: [
                      //Aumenta o tamanho do gradiente
                      const SizedBox(height: 105,),
                      WelcomeWidget(onTapButton: redirectToLogin),
                    ],
                  )),
            ],
          ),
        ),
      ),
      landscape: (context) => Scaffold(
        body: AnimatedBackgroundWidget(
          image: const Image(
            image: AssetImage('assets/images/presentation_background_landscape.jpg'),
            fit: BoxFit.cover,
          ),
          child: Column(
            children: [
              Expanded(
                child: GradiendBackgroundWidget(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlexibleSizedBox(
                        width: 100.sw,
                        height: 100.sw,
                        child: Center(child: WelcomeWidget(onTapButton: redirectToLogin)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}