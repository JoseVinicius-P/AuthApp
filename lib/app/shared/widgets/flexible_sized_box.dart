import 'package:flutter/cupertino.dart';

class FlexibleSizedBox extends StatelessWidget {
  const FlexibleSizedBox({Key? key, this.height, this.width, this.child}) : super(key: key);

  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: SizedBox(
          height: height,
          width: width,
          child: child,
        )
    );
  }
}
