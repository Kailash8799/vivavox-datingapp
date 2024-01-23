import 'package:flutter/material.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({super.key});

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color> animationOne;
  late Animation<Color> animationTwo;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationOne = ColorTween(begin: Colors.grey.shade100, end: Colors.grey)
        .animate(_controller) as Animation<Color>;
    animationTwo = ColorTween(begin: Colors.grey, end: Colors.grey.shade100)
        .animate(_controller) as Animation<Color>;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(colors: [animationOne.value, animationTwo.value])
            .createShader(bounds);
      },
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
