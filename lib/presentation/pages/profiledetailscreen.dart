import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreen();
}

class _ProfileDetailScreen extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          title: RichText(
              text: const TextSpan(children: [
            TextSpan(
              text: "Neha,",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(text: "  "),
            TextSpan(
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
        SliverToBoxAdapter(
          child: Hero(
            tag: data["keytag"],
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: data["image"],
                height: size.height - 400,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(15),
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color.fromARGB(255, 19, 21, 23),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      CupertinoIcons.search,
                      color: Color.fromARGB(255, 133, 138, 142),
                      size: 17,
                    )),
                    TextSpan(text: "  "),
                    TextSpan(
                      text: "Looking for",
                      style: TextStyle(
                        color: Color.fromARGB(255, 133, 138, 142),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "❤️ Short time fun",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
