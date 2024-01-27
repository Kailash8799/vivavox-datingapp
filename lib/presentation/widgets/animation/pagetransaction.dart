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

// class AnimationTransition extends MaterialPageRoute {
//   AnimationTransition({required super.builder, RouteSettings? routeSettings})
//       : super(maintainState: true, fullscreenDialog: false);

//   @override
//   bool get opaque => false;
//   // var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
//   //   CurveTween(curve: Curves.ease),
//   // );

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     // if (animation.status == AnimationStatus.reverse) {
//     return TweenAnimationBuilder(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 650),
//       child: child,
//       builder: (context, value, child2) {
//         return ShaderMask(
//           shaderCallback: (bounds) {
//             return RadialGradient(
//               radius: value * 5,
//               colors: const [
//                 Colors.white,
//                 Colors.white,
//                 Colors.transparent,
//                 Colors.transparent,
//               ],
//               stops: const [0.0, 0.55, 0.60, 1.0],
//               center: const FractionalOffset(1, 1),
//             ).createShader(bounds);
//           },
//           child: child2,
//         );
//       },
//     );
//     // }
//     // return child;
//   }
// }

// class AnimationTransition extends PageRouteBuilder {
//   AnimationTransition(
//       {required super.pageBuilder, required super.opaque, super.settings});
//   // var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
//   //   CurveTween(curve: Curves.ease),
//   // );

//   var reverseTween =
//       Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut));

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     if (secondaryAnimation.status == AnimationStatus.reverse) {
//       return TweenAnimationBuilder(
//         tween: Tween(begin: 1.0, end: 0.0),
//         duration: const Duration(milliseconds: 650),
//         child: child,
//         builder: (context, value, child2) {
//           return ShaderMask(
//             shaderCallback: (bounds) {
//               return RadialGradient(
//                 radius: value * 5,
//                 colors: const [
//                   Colors.white,
//                   Colors.white,
//                   Colors.transparent,
//                   Colors.transparent,
//                 ],
//                 stops: const [1.0, 0.60, 0.55, 0.0],
//                 // stops: const [0.0, 0.55, 0.60, 1.0],
//                 center: const FractionalOffset(0, 0),
//               ).createShader(bounds);
//             },
//             child: child2,
//           );
//         },
//       );
//       // }
//       // return child;
//     } else {
//       return TweenAnimationBuilder(
//         tween: Tween(begin: 0.0, end: 1.0),
//         duration: const Duration(milliseconds: 650),
//         child: child,
//         builder: (context, value, child2) {
//           return ShaderMask(
//             shaderCallback: (bounds) {
//               return RadialGradient(
//                 radius: value * 5,
//                 colors: const [
//                   Colors.white,
//                   Colors.white,
//                   Colors.transparent,
//                   Colors.transparent,
//                 ],
//                 stops: const [0.0, 0.55, 0.60, 1.0],
//                 center: const FractionalOffset(1, 1),
//               ).createShader(bounds);
//             },
//             child: child2,
//           );
//         },
//       );
//     }
//   }
// }

class AnimationTransition extends PageRouteBuilder {
  AnimationTransition({
    required super.pageBuilder,
    required super.opaque,
    super.settings,
  });

  @override
  bool get opaque => false;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (animation.status == AnimationStatus.forward) {
      // Enter Animation
      return TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.linear,
        child: child,
        builder: (context, value, child2) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return RadialGradient(
                radius: animation.value * 4,
                colors: const [
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 0.60, 1.0],
                center: const FractionalOffset(1, 1),
              ).createShader(bounds);
            },
            child: child2,
          );
        },
      );
    } else if (animation.status == AnimationStatus.reverse) {
      // Exit Animation
      return TweenAnimationBuilder(
        tween: Tween(begin: 1.0, end: 0.0),
        curve: Curves.linear,
        duration: const Duration(milliseconds: 1000),
        child: child,
        builder: (context, value, child2) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return RadialGradient(
                radius: animation.value * 4,
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
    }
    return child;
  }
}


// class PageWaveTransaction extends StatelessWidget {
//   final Widget screenroute;
//   const PageWaveTransaction({required this.screenroute, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             return TweenAnimationBuilder(
//                 tween: Tween(begin: 0.0, end: 1.0),
//                 duration: const Duration(milliseconds: 600),
//                 builder: (context, value, child) {
//                   return ShaderMask(
//                     shaderCallback: (rect) {
//                       return RadialGradient(
//                               radius: value * 5,
//                               colors: const [
//                                 Colors.white,
//                                 Colors.white,
//                                 Colors.transparent,
//                                 Colors.transparent
//                               ],
//                               stops: const [0.0, 0.55, 0.6, 1.0],
//                               center: const FractionalOffset(0.95, 0.95))
//                           .createShader(rect);
//                     },
//                     child: screenroute,
//                   );
//                 });
//           },
//         ));
//   }
// }
