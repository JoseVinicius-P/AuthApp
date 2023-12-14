import 'package:flutter/material.dart';
import 'package:auth/app/shared/services/my_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key, this.text, this.verticalPadding,
  });

  final String? text;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          SizedBox(width: verticalPadding),
          Expanded(child: Container(color: MyColors.grey.withOpacity(0.5), height: 0.5)),
          if(text != null) const SizedBox(width: 8,),
          if(text != null)  Text(
            text ?? '',
            style: theme.textTheme.labelSmall!.copyWith(color: MyColors.textColor.withOpacity(0.6), fontWeight: FontWeight.normal, fontSize: 18),
          ),
          if(text != null)  const SizedBox(width: 8,),
          Expanded(child: Container(color: MyColors.grey.withOpacity(0.5), height: 0.5)),
          SizedBox(width: verticalPadding),
        ],
      ),
    );
  }
}