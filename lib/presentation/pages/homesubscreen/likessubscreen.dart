import 'package:flutter/material.dart';

class LikessubScreen extends StatefulWidget {
  const LikessubScreen({super.key});

  @override
  State<LikessubScreen> createState() => _LikessubScreenState();
}

class _LikessubScreenState extends State<LikessubScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Comming soon!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          )),
    );
  }
}
