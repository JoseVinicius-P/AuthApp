import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auth/app/shared/services/my_colors.dart';


class QuestionAndButtonWidget extends StatelessWidget {
  const QuestionAndButtonWidget({
    super.key, required this.question, required this.buttonText, required this.onPressed,
  });

  final String question;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: AutoSizeText(
            question,
            style: theme.textTheme.labelSmall!.copyWith(color: MyColors.grey, fontWeight: FontWeight.normal),
            maxLines: 1,
            softWrap: true,
          ),
        ),
        Flexible(
          child: TextButton(
            onPressed: onPressed,
            child: AutoSizeText(
              buttonText,
              style: theme.textTheme.labelSmall!.copyWith(color: MyColors.primaryColor),
              maxLines: 1,
              softWrap: true,
            ),
          ),
        )
      ],
    );
  }
}