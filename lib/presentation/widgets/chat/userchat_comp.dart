import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vivavox/presentation/pages/chatroom.dart';
import 'package:vivavox/presentation/providers/chatprovider.dart';
import 'package:vivavox/presentation/widgets/animation/pageroute/slideanimation.dart';

class UserChatComp extends StatelessWidget {
  final String? lastmessagetime;
  final String usernmae;
  final String userid;
  final String? lastmessage;
  final String profileimage;
  final String chatid;

  const UserChatComp({
    super.key,
    this.lastmessage,
    this.lastmessagetime,
    required this.userid,
    required this.usernmae,
    required this.profileimage,
    required this.chatid,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context, listen: false);
    return InkWell(
      overlayColor:
          const MaterialStatePropertyAll(Color.fromARGB(255, 52, 54, 56)),
      onTap: () {
        provider.resetChat();
        Navigator.of(context).push(
          SlideTransitionRoute(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const ChatRoom();
              },
              opaque: true,
              settings: RouteSettings(arguments: {
                "chatid": chatid,
                "remoteprofile": {
                  "userid": userid,
                  "usernmae": usernmae,
                  "profileimage": profileimage,
                }
              })),
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
                  "Are you sure you want to delete this contact?",
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
                        Navigator.of(context).pop(false);
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
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: profileimage,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                      placeholder: (context, url) {
                        return SizedBox(
                          height: 60.0,
                          child: Shimmer.fromColors(
                            baseColor: Colors.white10,
                            highlightColor: Colors.grey,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.transparent,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return SizedBox(
                          height: 60.0,
                          child: Shimmer.fromColors(
                            baseColor: Colors.white10,
                            highlightColor: Colors.grey,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.white10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          trailing: Text(
            lastmessagetime ?? "",
            maxLines: 1,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          title: Text(
            usernmae,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: lastmessage == null
              ? const SizedBox(height: 0, width: 0)
              : Text(
                  lastmessage ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.blueGrey),
                ),
        ),
      ),
    );
  }
}
