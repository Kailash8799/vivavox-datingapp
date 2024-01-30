import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/providers/statusprovider.dart';

AppBar appbar({
  required BuildContext context,
  required Function updateProfile,
}) {
  final provider = Provider.of<ProfileProvider>(context);
  final statusprovider = Provider.of<StatusProvider>(context);
  return AppBar(
    surfaceTintColor: Colors.transparent,
    title: RichText(
        text: const TextSpan(children: [
      TextSpan(
        text: "Edit Profile",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ])),
    titleSpacing: 10,
    leading: const SizedBox(),
    leadingWidth: 0,
    actions: [
      provider.profileupdating
          ? Container(
              height: 35,
              width: 35,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.pink, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.5, 0.7]),
              ),
              padding: const EdgeInsets.all(4),
              child: const CupertinoActivityIndicator(
                color: Colors.white,
              ),
            )
          : IconButton(
              onPressed: () {
                if (provider.profileupdating) return;
                updateProfile();
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
                  Icons.save,
                  color: Colors.white,
                ),
              ),
            ),
      IconButton(
        onPressed: () {
          if (provider.profileupdating || statusprovider.imageaddingdeleting) {
            Fluttertoast.showToast(
              msg: "Wait a second",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return;
          }
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
        ),
      ),
    ],
    // backgroundColor: const Color.fromARGB(113, 107, 102, 107),

    // backgroundColor: Color(0xFF23272A),
    backgroundColor: Colors.black,
  );
}
