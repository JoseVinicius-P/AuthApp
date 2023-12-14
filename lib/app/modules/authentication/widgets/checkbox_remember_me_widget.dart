import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auth/app/shared/services/my_colors.dart';

class ChekboxRememberMeWidget extends StatefulWidget {
  const ChekboxRememberMeWidget({
    super.key, required this.onChanged, required this.checked,
  });
  final Function(bool?) onChanged;
  final bool checked;

  @override
  State<ChekboxRememberMeWidget> createState() => _ChekboxRememberMeWidgetState();
}

class _ChekboxRememberMeWidgetState extends State<ChekboxRememberMeWidget> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.checked;
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0), // Personaliza o arredondamento
          ),
          side: const BorderSide(
            color: MyColors.primaryColor,
            width: 2,
          ),
          value: isChecked,
          activeColor: MyColors.primaryColor,
          onChanged: (isChecked){
            setState(() {
              this.isChecked = isChecked!;
            });
            widget.onChanged(isChecked);
          },
        ),
        AutoSizeText(
          "Lembrar de mim",
          style: theme.textTheme.labelSmall!.copyWith(color: MyColors.textColor, fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      ],
    );
  }
}