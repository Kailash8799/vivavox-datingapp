import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/providers/statusprovider.dart';
import 'package:vivavox/services/auth/auth.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class AddMediaEditProfile extends StatefulWidget {
  const AddMediaEditProfile({super.key});

  @override
  State<AddMediaEditProfile> createState() => _AddMediaEditProfileState();
}

class _AddMediaEditProfileState extends State<AddMediaEditProfile> {
  bool adding = false;

  File? _imagefile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickPhoto() async {
    final per = await Permission.photos.request();
    if (per.isGranted) {
      final ImagePicker picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file == null) return;
      setState(() {
        _imagefile = File(file.path);
      });
    }
  }

  Future<void> pickFromCamera() async {
    final per = await Permission.camera.request();
    if (per.isGranted) {
      final ImagePicker picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.camera);
      if (file == null) return;
      setState(() {
        _imagefile = File(file.path);
      });
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if (_imagefile == null) return;

    final provider = Provider.of<CardProvider>(context, listen: false);
    final profileprovider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (provider.email.isEmpty) {
      return;
    }
    final statusprovider = Provider.of<StatusProvider>(context, listen: false);
    if (statusprovider.imageaddingdeleting) return;
    try {
      statusprovider.setImageDeleting(status: true);
      setState(() {
        adding = true;
      });
      Map<String, dynamic> res = await AuthUser().uploadImages(
          email: provider.email,
          image: _imagefile!,
          oldimage: profileprovider.profile!.images!);
      if (res["success"]) {
        profileprovider.addProfile(
            profileinfo: Profileinfo.fromJson(res["profile"]));
      } else {}
    } catch (e) {
      debugPrint('$e');
    }
    setState(() {
      adding = false;
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
          child: _imagefile != null
              ? SizedBox(
                  child: InkWell(
                    overlayColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                    onTap: showPickerSheet,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.file(
                        _imagefile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
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
                              const Color.fromARGB(255, 228, 98, 141),
                              const Color.fromARGB(255, 224, 110, 102),
                              const Color.fromARGB(255, 228, 115, 147)
                            ]
                          : [Colors.pink, Colors.red, const Color(0xFFFE3C72)]),
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (value.imageaddingdeleting) return;
                      if (_imagefile != null) {
                        uploadImage(context);
                        return;
                      }
                      showPickerSheet();
                    },
                    child: adding
                        ? const CupertinoActivityIndicator()
                        : Icon(
                            value.imageaddingdeleting
                                ? CupertinoIcons.lock
                                : _imagefile != null
                                    ? Icons.save
                                    : Icons.add,
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

  void showPickerSheet() {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: const Color.fromARGB(255, 30, 32, 34),
      elevation: 0,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          color: const Color.fromARGB(255, 19, 21, 23),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 30, 32, 34),
                ),
                height: size.width / 3,
                width: size.width / 3,
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
                height: size.width / 3,
                width: size.width / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 30, 32, 34),
                ),
                child: const Icon(
                  Icons.file_copy,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
