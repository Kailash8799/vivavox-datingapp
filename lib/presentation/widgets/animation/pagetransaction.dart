import 'package:flutter/material.dart';
// import 'package:vivavox/presentation/pages/loginscreen.dart';

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>
//         const LoginScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

class NoAnimationTransition extends MaterialPageRoute {
  NoAnimationTransition({required super.builder, RouteSettings? routeSettings})
      : super(maintainState: true, fullscreenDialog: false);

  var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
    CurveTween(curve: Curves.ease),
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (animation.status == AnimationStatus.reverse) {
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
    // }
    // return child;
  }
}
