import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    if (provider.profile == null) {
      Navigator.of(context).pop();
      return const SizedBox();
    }
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: provider.profile?.username ?? "None",
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(text: ", ", style: TextStyle(fontSize: 30)),
          const TextSpan(
            text: "20",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )
        ])),
        titleSpacing: 10,
        leading: const SizedBox(),
        leadingWidth: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.pink, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0, 0.5, 0.7]),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  CupertinoIcons.down_arrow,
                  color: Colors.white,
                ),
              ))
        ],
        // backgroundColor: const Color.fromARGB(113, 107, 102, 107),
        // backgroundColor: Color(0xFF23272A),
        backgroundColor: Colors.black,
      ),
    );
  }
}
