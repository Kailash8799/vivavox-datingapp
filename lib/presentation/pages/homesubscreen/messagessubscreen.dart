import 'package:flutter/material.dart';
import 'package:vivavox/presentation/widgets/chat/userchat_comp.dart';

class MessagesubScreen extends StatefulWidget {
  const MessagesubScreen({super.key});

  @override
  State<MessagesubScreen> createState() => _MessagesubScreenState();
}

class _MessagesubScreenState extends State<MessagesubScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const UserChatComp(
                lastmessage: "Hello janu",
                lastmessagetime: "12:05 AM",
                userid: "234",
                usernmae: "Kailash Rajput",
                profileimage: "",
              );
            },
          ),
        )
      ],
    );
  }
}
