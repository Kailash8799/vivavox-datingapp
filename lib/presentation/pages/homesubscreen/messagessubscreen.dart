import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/pages/selectchat.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/widgets/animation/pagetransaction.dart';
import 'package:vivavox/presentation/widgets/chat/userchat_comp.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class MessagesubScreen extends StatefulWidget {
  const MessagesubScreen({super.key});

  @override
  State<MessagesubScreen> createState() => _MessagesubScreenState();
}

class _MessagesubScreenState extends State<MessagesubScreen> {
  @override
  Widget build(BuildContext context) {
    final profileprovider = Provider.of<ProfileProvider>(context);
    List<LikesUser> profile = [];
    profileprovider.profile!.likes!.forEach((element) {
      profileprovider.profile!.likes!.forEach((element2) {
        if (element.user.id == element2.user.id) {
          profile.add(element.user);
        }
      });
    });
    return Scaffold(
      floatingActionButton: TextButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(100)),
          maximumSize: const Size(60, 60),
          minimumSize: const Size(60, 60),
          backgroundColor: const Color(0xFFFE3C72),
        ),
        onPressed: () {
          Navigator.of(context).push(
            AnimationTransition(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const SelectChatContact();
              },
              opaque: false,
            ),
          );
        },
        child: const Center(
            child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 26,
        )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: profile.length,
              itemBuilder: (context, index) {
                return UserChatComp(
                  lastmessage: "Hello janu",
                  lastmessagetime: "12:05 AM",
                  userid: profile[index].id!,
                  usernmae: profile[index].username!,
                  profileimage: profile[index].profileimage!,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
