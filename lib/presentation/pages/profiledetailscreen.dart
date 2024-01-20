import 'package:cached_network_image/cached_network_image.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
      ),
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("Neha"),
          backgroundColor: Color.fromARGB(113, 107, 102, 107),
        ),
        SliverToBoxAdapter(
          child: Hero(
            tag: data["keytag"],
            child: CachedNetworkImage(
              imageUrl: data["image"],
            ),
          ),
        )
      ]),
    );
  }
}
