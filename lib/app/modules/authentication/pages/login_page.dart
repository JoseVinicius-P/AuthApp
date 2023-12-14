import 'package:auth/app/modules/authentication/interfaces/i_login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:auth/app/modules/authentication/widgets/checkbox_remember_me_widget.dart';
import 'package:auth/app/modules/authentication/widgets/divider_widget.dart';
import 'package:auth/app/modules/authentication/widgets/form_widget.dart';
import 'package:auth/app/modules/authentication/widgets/google_button_widget.dart';
import 'package:auth/app/modules/authentication/widgets/question_and_button_widget.dart';
import 'package:auth/app/modules/authentication/widgets/title_widget.dart';
import 'package:auth/app/shared/services/my_edge_insets.dart';
import 'package:auth/app/shared/widgets/default_button_widget.dart';
import 'package:auth/app/shared/services/my_colors.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {
  final store = Modular.get<ILoginStore>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var questionAndButton = TripleBuilder(
      store: store,
      builder: (context, triple) {
        return QuestionAndButtonWidget(
          question: "Não tem uma conta?",
          buttonText: "Criar agora",
          onPressed: triple.isLoading ? null : () => Modular.to.pushReplacementNamed('./create_account'),
        );
      }
    );
    var form = TripleBuilder(
        store: store,
        builder: (context, triple) {
          return FormWidget(
            onChangedEmail: (email) => store.updateEmail(email),
            onChangedPassword: (password) => store.updatePassword(password),
            error: triple.error,
            enable: !triple.isLoading,
          );
        }
    );
    var checkboxRememberMe = ChekboxRememberMeWidget(
      checked: true,
      onChanged: (rememberMe) => store.updateRememberMe(rememberMe ?? false),
    );
    var loginButton = TripleBuilder(
      store: store,
      builder: (context, triple) {
        return DefaultButtonWidget(
          onTap: triple.isLoading ? null : () => store.signInWithEmailAndPassword(),
          text: triple.isLoading ? 'Entrando, aguarde...' : 'Login',
          backgroundColor: MyColors.primaryColor,
          textColor: MyColors.textButtonColor,
          shadow: true,
        );
      }
    );
    var googleButton = TripleBuilder(
      store: store,
      builder: (context, triple) {
        return GoogleButtonWidget(onTap: triple.isLoading ? null : () => store.signInWithGoogle(), withText: false,);
      }
    );
    const String title = 'Entrar na sua \nconta';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: MyEdgeInsets.getInsetsBelowStatusBar(context),
        child: OrientationLayoutBuilder(
          portrait: (context) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        const Flexible(child: SizedBox(height: 50,)),
                        // ignore: prefer_const_constructors
                        TitleWidget(
                          text: title,
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        form,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: checkboxRememberMe),
                          ],
                        ),
                        const Flexible(child: SizedBox(height: 15,)),
                        loginButton,
                        const Spacer(),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DividerWidget(text: "ou continue com"),
                        const Flexible(child: SizedBox(height: 15,)),
                        Row(mainAxisSize: MainAxisSize.min, children: [googleButton],
                        ),
                        const Flexible(child: SizedBox(height: 25,)),
                        questionAndButton,
                      ],
                    )
                ),
              ],
            );
          },
          landscape: (context) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  flex: 1,
                  child: TitleWidget(
                    text: title,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        form,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: checkboxRememberMe),
                          ],
                        ),
                        const Flexible(child: SizedBox(height: 15,)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(child: googleButton),
                            const SizedBox(width: 10,),
                            Flexible(
                                child: loginButton
                            ),

                          ],
                        ),
                        const Spacer(),
                        questionAndButton,
                      ],
                    )
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}