import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Imageskeleton extends StatelessWidget {
  const Imageskeleton({super.key, height, width})
      : _height = height,
        _width = width;
  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: _height,
      child: Shimmer.fromColors(
          baseColor: const Color(0xFFEBEBF1),
          highlightColor: Colors.white,
          child: Container(
            width: _width,
            height: _height,
            color: const Color(0xFFEBEBF1),
          )),
    );
  }
}
