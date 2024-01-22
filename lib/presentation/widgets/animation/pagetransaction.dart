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

  // var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
  //   CurveTween(curve: Curves.ease),
  // );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (animation.status == AnimationStatus.reverse) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 650),
      child: child,
      builder: (context, value, child2) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return RadialGradient(
              radius: value * 5,
              colors: const [
                Colors.white,
                Colors.white,
                Colors.transparent,
                Colors.transparent,
              ],
              stops: const [0.0, 0.55, 0.60, 1.0],
              center: const FractionalOffset(1, 1),
            ).createShader(bounds);
          },
          child: child2,
        );
      },
    );
    // }
    // return child;
  }
}
