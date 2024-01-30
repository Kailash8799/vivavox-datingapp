import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vivavox/presentation/pages/homescreen.dart';
import 'package:vivavox/presentation/pages/splashscreen.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/widgets/animation/pagetransaction.dart';
import 'package:vivavox/services/auth/auth.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void transferScreen({required bool isLogin}) {
    if (isLogin) {
      Navigator.of(context).pushAndRemoveUntil(
          AnimationTransition(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              return const HomeScreen();
            },
          ),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          AnimationTransition(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              return const Splashscreen();
            },
          ),
          (route) => false);
    }
  }

  void getStatus() async {
    try {
      final SharedPreferences status = await SharedPreferences.getInstance();
      final String? token = status.getString("auth_token");
      if (token == null) {
        transferScreen(isLogin: false);
        return;
      }
      AuthUser user = AuthUser();
      Map<String, dynamic> responce = await user.getProfile(token: token);
      if (responce["success"] == true) {
        if (!context.mounted) return;
        final provider = Provider.of<ProfileProvider>(context, listen: false);
        final cardprovider = Provider.of<CardProvider>(context, listen: false);
        provider.addProfile(
            profileinfo: Profileinfo.fromJson(responce["profile"]));
        cardprovider.setMail(
            email: responce["profile"]["email"] as String,
            swipes: responce["profile"]["allswipe"] ?? []);
        cardprovider.initialize();
        transferScreen(isLogin: true);
      } else {
        await status.remove("auth_token");
        transferScreen(isLogin: false);
      }
    } catch (e) {
      print(e);
      final SharedPreferences status = await SharedPreferences.getInstance();
      await status.remove("auth_token");
      transferScreen(isLogin: false);
    }
  }

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
