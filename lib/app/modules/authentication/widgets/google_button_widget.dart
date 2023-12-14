import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auth/app/shared/services/my_colors.dart';
import 'package:auth/app/shared/services/my_edge_insets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({
    super.key, this.onTap, this.withText,
  });

  final void Function()? onTap;
  final bool? withText;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(17),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: MyColors.grey.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Padding(
          padding: withText == null || withText! ? MyEdgeInsets.insideButton :
          MyEdgeInsets.googleButtonWithoutText,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/icon_google.png'),
                width: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(width: withText == null || withText! ? 8 : 0),
              withText == null || withText! ? Flexible(
                child: AutoSizeText(
                  maxLines: 1,
                  minFontSize: 2.5.sw.roundToDouble(),
                  'Continuar com o google',
                  style: theme.textTheme.labelSmall!.copyWith( color: MyColors.textColor),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ): const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}