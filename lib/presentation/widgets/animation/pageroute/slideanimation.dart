import 'package:flutter/material.dart';

class SlideTransitionRoute extends PageRouteBuilder {
  SlideTransitionRoute({
    required super.pageBuilder,
    required super.opaque,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Enter Animation
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.linear;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      textDirection: TextDirection.ltr,
      child: child,
    );
  }
}
