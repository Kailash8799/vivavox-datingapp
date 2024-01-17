import 'package:flutter/material.dart';

class MessagesubScreen extends StatefulWidget {
  const MessagesubScreen({super.key});

  @override
  State<MessagesubScreen> createState() => _MessagesubScreenState();
}

class _MessagesubScreenState extends State<MessagesubScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Messages"),
    );
  }
}
