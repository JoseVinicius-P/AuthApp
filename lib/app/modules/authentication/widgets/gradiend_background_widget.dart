import 'package:flutter/material.dart';

class GradiendBackgroundWidget extends StatelessWidget {
  const GradiendBackgroundWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.7)],
        ),
      ),
      child: child,
    );
  }
}