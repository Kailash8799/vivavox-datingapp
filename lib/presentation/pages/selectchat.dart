import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/widgets/chat/select_chat.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class SelectChatContact extends StatefulWidget {
  const SelectChatContact({super.key});

  @override
  State<SelectChatContact> createState() => _SelectChatContactState();
}

class _SelectChatContactState extends State<SelectChatContact> {
  @override
  Widget build(BuildContext context) {
    final profileprovider = Provider.of<ProfileProvider>(context);
    List<LikesUser> profile = [];
    for (var element in profileprovider.profile!.likes!) {
      for (var element2 in profileprovider.profile!.remotelikes!) {
        if (element.user.id == element2.user.id) {
          profile.add(element.user);
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 15, 15),
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Select contact",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: profile.isEmpty
          ? const Center(
              child: Text(
                "No match found",
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: profile.length,
                    padding: const EdgeInsets.only(bottom: 50, top: 10),
                    itemBuilder: (context, index) {
                      return SelectChatComp(
                        userid: profile[index].id!,
                        usernmae: profile[index].username!,
                        profileimage: profile[index].profileimage!,
                        remoteemail: profile[index].email!,
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
