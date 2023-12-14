import 'package:auth/app/modules/authentication/interfaces/i_create_account_store.dart';
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

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}
class CreateAccountPageState extends State<CreateAccountPage> {
  final store = Modular.get<ICreateAccountStore>();

  @override
  Widget build(BuildContext context) {
    var questionAndButton = TripleBuilder(
      store: store,
      builder: (context, triple) {
        return QuestionAndButtonWidget(
          question: "Já tem uma conta?",
          buttonText: "Fazer Login",
          onPressed: triple.isLoading ? null : () => Modular.to.pushReplacementNamed("./login"),
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
      onChanged: (rememberMe) => store.updateRememberMe(rememberMe ?? false)
    );
    var createAccountButton = TripleBuilder(
      store: store,
      builder: (context, triple) {
        return DefaultButtonWidget(
          onTap: triple.isLoading ? null : () => store.createAccount(),
          text: triple.isLoading ? 'Cadastrando, aguarde...' : 'Criar conta',
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
    const String title = 'Criar sua \nconta';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: MyEdgeInsets.standard,
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
                        checkboxRememberMe,
                        const Flexible(child: SizedBox(height: 15,)),
                        createAccountButton,
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
                        checkboxRememberMe,
                        const Flexible(child: SizedBox(height: 15,)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(child: googleButton),
                            const SizedBox(width: 10,),
                            Flexible(
                                child: createAccountButton
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