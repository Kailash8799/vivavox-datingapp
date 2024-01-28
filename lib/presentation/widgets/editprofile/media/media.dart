import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/providers/statusprovider.dart';
import 'package:vivavox/services/auth/auth.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class MediaEditProfile extends StatefulWidget {
  final String image;
  const MediaEditProfile({super.key, required this.image});

  @override
  State<MediaEditProfile> createState() => _MediaEditProfileState();
}

class _MediaEditProfileState extends State<MediaEditProfile> {
  bool deleting = false;

  Future<void> deleteImage(BuildContext context) async {
    final provider = Provider.of<CardProvider>(context, listen: false);
    final profileprovider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (provider.email.isEmpty ||
        profileprovider.profile!.images == null ||
        profileprovider.profile!.images!.isEmpty) {
      return;
    }
    final statusprovider = Provider.of<StatusProvider>(context, listen: false);
    if (statusprovider.imageaddingdeleting) return;
    try {
      statusprovider.setImageDeleting(status: true);
      setState(() {
        deleting = true;
      });
      Map<String, dynamic> res = await AuthUser()
          .deleteImages(email: provider.email, oldimage: widget.image);
      if (res["success"]) {
        profileprovider.addProfile(
            profileinfo: Profileinfo.fromJson(res["profile"]));
      } else {}
    } catch (e) {
      debugPrint('$e');
    }
    setState(() {
      deleting = false;
    });
    statusprovider.setImageDeleting(status: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.all(6),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 119, 129, 139),
            borderRadius: BorderRadius.circular(7),
          ),
          child: SizedBox(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: CachedNetworkImage(
                    imageUrl: widget.image, fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Consumer<StatusProvider>(
            builder: (context, value, child) {
              return Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: value.imageaddingdeleting
                          ? [
                              const Color.fromARGB(255, 174, 174, 174),
                              const Color.fromARGB(255, 152, 169, 177)
                            ]
                          : [Colors.grey, Colors.blueGrey]),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (value.imageaddingdeleting) return;
                      deleteImage(context);
                    },
                    child: deleting
                        ? const CupertinoActivityIndicator()
                        : Icon(
                            value.imageaddingdeleting
                                ? CupertinoIcons.lock
                                : CupertinoIcons.multiply,
                            color: Colors.white,
                          ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
