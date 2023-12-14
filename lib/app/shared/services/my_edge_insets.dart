

import 'package:flutter/cupertino.dart';

class MyEdgeInsets {
  static const standard = EdgeInsets.all(15.0);
  static const insideButton = EdgeInsets.all(13.0);
  static const insideTextBubble = EdgeInsets.all(8.0);
  static const insideContactMethod = EdgeInsets.all(25.0);
  static const googleButtonWithoutText = EdgeInsets.symmetric(horizontal: 30, vertical: 12);



  static getInsetsBelowStatusBar(BuildContext context){
    return standard.copyWith(top: MediaQuery.of(context).padding.top + standard.top);
  }
}