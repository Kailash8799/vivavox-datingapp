import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/chatprovider.dart';
import 'package:vivavox/presentation/providers/statusprovider.dart';
import 'package:vivavox/services/chat/chat_service.dart';

class SelectChatComp extends StatefulWidget {
  final String usernmae;
  final String userid;
  final String profileimage;
  final String remoteemail;

  const SelectChatComp({
    super.key,
    required this.userid,
    required this.usernmae,
    required this.profileimage,
    required this.remoteemail,
  });

  @override
  State<SelectChatComp> createState() => _SelectChatCompState();
}

class _SelectChatCompState extends State<SelectChatComp> {
  Future<bool> createChat() async {
    final statusprovider = Provider.of<StatusProvider>(context, listen: false);
    final cardprovider = Provider.of<CardProvider>(context, listen: false);
    if (statusprovider.chatcreating || cardprovider.email.isEmpty) return false;
    statusprovider.setChatcreating(status: true);
    try {
      Map<String, dynamic> responce = await ChatService().createChat(
        id: widget.userid,
        email: cardprovider.email,
        remoteemail: widget.remoteemail,
      );
      if (responce["success"]) {
        if (!mounted) return false;
        final chatprovider = Provider.of<ChatProvider>(context, listen: false);
        chatprovider.setCreatedChat(dynamicchatList: responce["allchat"]);
        Fluttertoast.showToast(
          msg: responce["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: responce["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Some error occurred!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    statusprovider.setChatcreating(status: false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final statusprovider = Provider.of<StatusProvider>(context);
    return PopScope(
      canPop: !statusprovider.chatcreating,
      child: InkWell(
        overlayColor:
            const MaterialStatePropertyAll(Color.fromARGB(255, 52, 54, 56)),
        onTap: () async {
          final res = await showCupertinoDialog(
            context: context,
            builder: (context) {
              return Consumer<StatusProvider>(
                builder: (context2, value, child) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 19, 21, 23),
                    surfaceTintColor: Colors.transparent,
                    title: const Text(
                      "Create a chat?",
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
                            bool val = await createChat();
                            if (val) {
                              if (!context.mounted) return;
                              Navigator.of(context).pop(true);
                              Navigator.of(context).pop();
                            }
                          },
                          child: value.chatcreating
                              ? const CupertinoActivityIndicator()
                              : const Text(
                                  "YES",
                                  style: TextStyle(color: Colors.red),
                                )),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            mouseCursor: MaterialStateMouseCursor.clickable,
            splashColor: Colors.red,
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 24, 25, 26),
              maxRadius: 30,
              minRadius: 30,
              child: widget.profileimage.isEmpty
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: widget.profileimage,
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
            title: Text(
              widget.usernmae,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
