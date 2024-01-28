import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vivavox/presentation/pages/prifilescreen.dart';
import 'package:vivavox/presentation/pages/splashscreen.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/widgets/animation/pagetransaction.dart';
import 'package:vivavox/services/auth/auth.dart';

class ProfilesubScreen extends StatefulWidget {
  const ProfilesubScreen({super.key});

  @override
  State<ProfilesubScreen> createState() => _ProfilesubScreenState();
}

class _ProfilesubScreenState extends State<ProfilesubScreen> {
  // DocumentSnapshot? user;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Center(
                    child: Stack(
                  children: [
                    CircleAvatar(
                      minRadius: 100,
                      maxRadius: 100,
                      backgroundColor: Colors.white10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return SizedBox(
                                height: 150.0,
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
                                height: 150.0,
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
                            imageUrl: provider.profile!.profileimage ?? ""),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).push(
                              AnimationTransition(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const OwnProfileScreen();
                                },
                                opaque: false,
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFE3C72),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            )),
                          ),
                        ))
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My listening status",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Change display name",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Change password",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Change email",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email preferences",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Change tariff plan",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(255, 19, 21, 23),
                        surfaceTintColor: Colors.transparent,
                        title: const Text(
                          "Are sure you want logout account?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "NO",
                                style: TextStyle(color: Colors.white),
                              )),
                          TextButton(
                              onPressed: () async {
                                Map<String, dynamic> res =
                                    await AuthUser().logOut();
                                if (res["success"]) {
                                  if (!context.mounted) return;
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      AnimationTransition(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return const Splashscreen();
                                          },
                                          opaque: false),
                                      (route) => false);
                                }
                              },
                              child: const Text(
                                "YES",
                                style: TextStyle(color: Colors.red),
                              )),
                        ],
                      );
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delete account",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
