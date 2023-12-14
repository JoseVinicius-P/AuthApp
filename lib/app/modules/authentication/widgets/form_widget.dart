import 'package:flutter/material.dart';
import 'package:auth/app/shared/widgets/text_field_widget.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    super.key,
    required this.onChangedEmail,
    required this.onChangedPassword,
    this.error, this.enable,
  });

  final void Function(String) onChangedEmail;
  final Function(String) onChangedPassword;
  final String? error;
  final bool? enable;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  @override
  Widget build(BuildContext context) {
    var focusPassword = FocusNode();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFieldWidget(
          hint: 'Email',
          enable: widget.enable,
          prefixIcon: Icons.email_rounded,
          keyboardType: TextInputType.emailAddress,
          onChanged: (text) => widget.onChangedEmail(text),
          error: widget.error != null && widget.error!.isNotEmpty ? ' ': null,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_){
            FocusScope.of(context).requestFocus(focusPassword);
          },
        ),
        const SizedBox(height: 5,),
        TextFieldWidget(
          hint: 'Senha',
          enable: widget.enable,
          prefixIcon: Icons.lock,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (text) => widget.onChangedPassword(text),
          error: widget.error,
          focusNode: focusPassword,
        ),
      ],
    );
  }
}