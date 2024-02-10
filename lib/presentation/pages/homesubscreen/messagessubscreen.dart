import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/pages/selectchat.dart';
import 'package:vivavox/presentation/providers/chatprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/widgets/animation/pagetransaction.dart';
import 'package:vivavox/presentation/widgets/chat/userchat_comp.dart';
import 'package:vivavox/presentation/widgets/date_time_extension.dart';

class MessagesubScreen extends StatefulWidget {
  const MessagesubScreen({super.key});

  @override
  State<MessagesubScreen> createState() => _MessagesubScreenState();
}

class _MessagesubScreenState extends State<MessagesubScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatprovider = Provider.of<ChatProvider>(context);
    final profileprovider = Provider.of<ProfileProvider>(context);
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
      body: chatprovider.chatfetching
          ? const Center(
              child: CupertinoActivityIndicator(
                radius: 20,
                color: Colors.white,
              ),
            )
          : profileprovider.profile == null || chatprovider.allchats.isEmpty
              ? const Center(
                  child: Text(
                    "No chat found",
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10, top: 5),
                        itemCount: chatprovider.allchats.length,
                        itemBuilder: (context, index) {
                          final remoteuser = profileprovider.profile!.id ==
                                  chatprovider.allchats[index].user1.id
                              ? chatprovider.allchats[index].user2
                              : chatprovider.allchats[index].user1;
                          return UserChatComp(
                            chatid: chatprovider.allchats[index].chatid,
                            lastmessage: chatprovider
                                .allchats[index].latestMessage?.message,
                            lastmessagetime: chatprovider
                                .allchats[index].latestMessage?.messagetime
                                .timeAgo(numericDates: false),
                            userid: remoteuser.id!,
                            usernmae: remoteuser.username!,
                            profileimage: remoteuser.profileimage!,
                          );
                        },
                      ),
                    )
                  ],
                ),
    );
  }
}
