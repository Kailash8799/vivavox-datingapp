import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vivavox/presentation/pages/chatroom.dart';
import 'package:vivavox/presentation/widgets/animation/pageroute/slideanimation.dart';

class UserChatComp extends StatelessWidget {
  final String lastmessagetime;
  final String usernmae;
  final String userid;
  final String lastmessage;
  final String profileimage;

  const UserChatComp({
    super.key,
    required this.lastmessage,
    required this.lastmessagetime,
    required this.userid,
    required this.usernmae,
    required this.profileimage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor:
          const MaterialStatePropertyAll(Color.fromARGB(255, 52, 54, 56)),
      onTap: () {
        Navigator.of(context).push(
          SlideTransitionRoute(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const ChatRoom();
            },
            opaque: true,
          ),
        );
      },
      child: Dismissible(
        key: Key(userid.toString()),
        direction: DismissDirection.endToStart,
        dismissThresholds: const {DismissDirection.endToStart: 0.35},
        behavior: HitTestBehavior.opaque,
        confirmDismiss: (direction) async {
          final res = await showCupertinoDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: const Color.fromARGB(255, 19, 21, 23),
                surfaceTintColor: Colors.transparent,
                title: const Text(
                  "Are you sure you want to delete the account?",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text(
                        "NO",
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        "YES",
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              );
            },
          );

          return res;
        },
        background: Container(
          color: Colors.transparent,
          child: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        child: ListTile(
          mouseCursor: MaterialStateMouseCursor.clickable,
          splashColor: Colors.red,
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 24, 25, 26),
            maxRadius: 30,
            minRadius: 30,
            child: profileimage.isEmpty
                ? const SizedBox()
                : CachedNetworkImage(
                    imageUrl: profileimage,
                  ),
          ),
          trailing: Text(
            lastmessagetime,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          title: Text(
            usernmae,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            lastmessage,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}