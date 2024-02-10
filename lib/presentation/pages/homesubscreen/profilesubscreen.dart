import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vivavox/presentation/pages/prifilescreen.dart';
import 'package:vivavox/presentation/pages/splashscreen.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/providers/statusprovider.dart';
import 'package:vivavox/presentation/widgets/animation/pagetransaction.dart';
import 'package:vivavox/services/auth/auth.dart';
import 'package:vivavox/services/model/profileinfo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilesubScreen extends StatefulWidget {
  const ProfilesubScreen({super.key});

  @override
  State<ProfilesubScreen> createState() => _ProfilesubScreenState();
}

class _ProfilesubScreenState extends State<ProfilesubScreen> {
  File? _imagefile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickPhoto() async {
    final per = await Permission.photos.request();
    if (per.isGranted) {
      final ImagePicker picker = ImagePicker();
      final xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) return;
      File file = File(xFile.path);
      int fileSizeInBytes = file.lengthSync();
      double fileSizeInKB = fileSizeInBytes / 1024;
      if (fileSizeInKB > 3500) {
        Fluttertoast.showToast(
          msg: "Maximum image size is 3.4MB",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }
      setState(() {
        _imagefile = file;
      });
    }
  }

  Future<void> pickFromCamera() async {
    final per = await Permission.photos.request();
    if (per.isGranted) {
      final ImagePicker picker = ImagePicker();
      final xFile = await picker.pickImage(source: ImageSource.camera);
      if (xFile == null) return;
      File file = File(xFile.path);
      int fileSizeInBytes = file.lengthSync();
      double fileSizeInKB = fileSizeInBytes / 1024;
      if (fileSizeInKB > 3500) {
        Fluttertoast.showToast(
          msg: "Maximum image size is 3.4MB",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }
      setState(() {
        _imagefile = file;
      });
    }
  }

  void updateProfile() async {
    if (_imagefile == null) return;
    final provider = Provider.of<CardProvider>(context, listen: false);
    final profileprovider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (provider.email.isEmpty) return;
    final statusprovider = Provider.of<StatusProvider>(context, listen: false);
    if (statusprovider.profileimageupdating) return;
    try {
      statusprovider.setProfileimageupdating(status: true);
      Map<String, dynamic> data = await AuthUser().updateProfileImage(
        email: provider.email,
        image: _imagefile!,
        oldimage: profileprovider.profile!.profileimage,
      );
      if (data["success"]) {
        profileprovider.addProfile(
            profileinfo: Profileinfo.fromJson(data["profile"]));
        setState(() {
          _imagefile = null;
        });
        Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
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
    statusprovider.setProfileimageupdating(status: false);
  }

  void deleteProfileImage() async {
    final provider = Provider.of<CardProvider>(context, listen: false);
    final profileprovider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (provider.email.isEmpty ||
        profileprovider.profile!.profileimage == null ||
        profileprovider.profile!.profileimage == profileprovider.defaultimage) {
      Fluttertoast.showToast(
        msg: "No image to delete",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    final statusprovider = Provider.of<StatusProvider>(context, listen: false);
    if (statusprovider.profileimageupdating) {
      Fluttertoast.showToast(
        msg: "Image updating in process",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    try {
      statusprovider.setProfileimageupdating(status: true);
      Map<String, dynamic> data = await AuthUser().deleteProfileImage(
        email: provider.email,
        oldimage: profileprovider.profile!.profileimage!,
      );
      if (data["success"]) {
        profileprovider.addProfile(
            profileinfo: Profileinfo.fromJson(data["profile"]));
        Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
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
    setState(() {
      _imagefile = null;
    });
    statusprovider.setProfileimageupdating(status: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    final cardprovider = Provider.of<CardProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Center(
                    child: Stack(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.transparent),
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
                      child: CircleAvatar(
                        minRadius: 200,
                        maxRadius: 200,
                        backgroundColor: Colors.white10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _imagefile != null
                              ? Image.file(
                                  _imagefile!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  width: 200,
                                  height: 200,
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
                                  imageUrl:
                                      provider.profile!.profileimage ?? "",
                                ),
                        ),
                      ),
                    ),
                    _imagefile == null
                        ? const Positioned(
                            child: SizedBox(
                            height: 0,
                            width: 0,
                          ))
                        : Positioned(
                            bottom: 10,
                            left: 10,
                            child: InkWell(
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          const Color.fromARGB(255, 19, 21, 23),
                                      surfaceTintColor: Colors.transparent,
                                      title: const Text(
                                        "Are sure you want change image?",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _imagefile = null;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "NO",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              updateProfile();
                                            },
                                            child: const Text(
                                              "YES",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                      ],
                                    );
                                  },
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
                                child: Consumer<StatusProvider>(
                                  builder: (context, value, child) {
                                    if (value.profileimageupdating) {
                                      return const CupertinoActivityIndicator(
                                          color: Colors.white);
                                    }
                                    return const Center(
                                      child: Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )),
                    Consumer<StatusProvider>(
                      builder: (context, value, child) {
                        return value.profileimageupdating
                            ? const Center(
                                child: CupertinoActivityIndicator(
                                    radius: 20, color: Colors.white),
                              )
                            : const Positioned(
                                child: SizedBox(
                                height: 0,
                                width: 0,
                              ));
                      },
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              backgroundColor:
                                  const Color.fromARGB(255, 30, 32, 34),
                              elevation: 0,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 200,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  color: const Color.fromARGB(255, 19, 21, 23),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            pickFromCamera();
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  255, 30, 32, 34),
                                            ),
                                            height: size.width / 3.5,
                                            width: size.width / 3.5,
                                            child: const Icon(
                                              CupertinoIcons.camera,
                                              size: 50,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            pickPhoto();
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            height: size.width / 3.5,
                                            width: size.width / 3.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  255, 30, 32, 34),
                                            ),
                                            child: const Icon(
                                              Icons.file_copy,
                                              size: 50,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            if (provider
                                                    .profile!.profileimage ==
                                                provider.defaultimage) {
                                              return;
                                            }
                                            deleteProfileImage();
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  255, 30, 32, 34),
                                            ),
                                            height: size.width / 3.5,
                                            width: size.width / 3.5,
                                            child: Icon(
                                              CupertinoIcons.delete,
                                              size: 50,
                                              color: provider.profile!
                                                          .profileimage ==
                                                      provider.defaultimage
                                                  ? Colors.redAccent.shade100
                                                  : Colors.red,
                                            ),
                                          ),
                                        ),
                                      ]),
                                );
                              },
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
                                  cardprovider.setMail(email: "", swipes: []);
                                  cardprovider.resetProfiles();
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
                        "Logout",
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
