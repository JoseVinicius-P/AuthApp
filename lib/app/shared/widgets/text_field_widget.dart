import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth/app/shared/services/my_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldWidget extends StatefulWidget {
  final String hint;
  final bool? enable;
  final String? error;
  final MaskTextInputFormatter? maskFormatter;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onPressedSuffixIcon;

  const TextFieldWidget({
    Key? key,
    required this.hint,
    this.maskFormatter,
    this.enable,
    this.prefixIcon,
    this.keyboardType,
    this.maxLength,
    this.controller,
    this.error,
    this.onChanged,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted, this.suffixIcon,
    this.onPressedSuffixIcon
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode _focusNode;
  String text = "";
  late bool isPassword;
  bool obscureText = true;

  void initFocus(){
    if(widget.focusNode != null){
      _focusNode = widget.focusNode!;
    }else{
      _focusNode = FocusNode();
    }
  }

  @override
  void initState() {
    super.initState();
    initFocus();
    _focusNode.addListener(() {
      setState(() {});
    });

    isPassword = widget.keyboardType == TextInputType.visiblePassword;
    obscureText = isPassword;
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Importante descartar o FocusNode ao final
    super.dispose();
  }

  Color getColor(){
    if(widget.error != null && widget.error!.isNotEmpty){
      return MyColors.errorColor;
    }else if(_focusNode.hasFocus){
      return MyColors.primaryColor;
    }else if(text.isEmpty){
      return MyColors.grey;
    }else{
      return MyColors.textColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          enabled: widget.enable,
          inputFormatters: widget.maskFormatter != null ?
          [
            widget.maskFormatter!,
            LengthLimitingTextInputFormatter(widget.maxLength),
          ] :
          [
            LengthLimitingTextInputFormatter(widget.maxLength)
          ],
          keyboardType: widget.keyboardType,
          onChanged: (text){
            setState(() {
              this.text = text;
            });
            widget.onChanged?.call(text);
          },
          obscureText: obscureText,
          focusNode: _focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          //definindo estilo do texto
          style: theme.textTheme.labelSmall!.copyWith(color: MyColors.textColor),
          cursorColor: MyColors.textColor,
          //retirando autocorreção de texto
          autocorrect: false,
          //definindo estilo do container do textfield
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: MyColors.primaryColor),
              borderRadius: BorderRadius.circular(15),
            ),
            fillColor: _focusNode.hasFocus ? MyColors.secondaryColor : MyColors.grayLight,
            //Definindo hint usando varivel da classe personalizada MyStrings
            hintText: widget.hint,
            hintStyle: theme.textTheme.labelSmall!.copyWith(color: getColor()),
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: getColor()) : null,
            suffixIcon: isPassword ? IconButton(
              onPressed: isPassword ? (){
                setState(() {
                  obscureText = !obscureText;
                });
              } : null,
              icon: Icon(obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: isPassword ? getColor() : Colors.transparent),
            ) :
            IconButton(
              onPressed: widget.onPressedSuffixIcon,
              icon: Icon(widget.suffixIcon, color:  getColor()),
            ),
            filled: true,
          ),
        ),
        const SizedBox(height: 5,),
        Text(
        widget.error != null && widget.error != "" ? "     ${widget.error}" : "",
          style: const TextStyle(
            color: MyColors.errorColor
          ),
        )
      ],
    );
  }
}