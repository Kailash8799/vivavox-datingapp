import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vivavox/presentation/pages/forgotpassword.dart';
import 'package:vivavox/presentation/pages/homescreen.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/widgets/snakbar.dart';
import 'package:vivavox/services/auth/auth.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;

  static bool _isPasswordhidden = true;

  Future<void> userLogin(BuildContext context) async {
    final String email = _email.text.trim();
    final String password = _password.text.trim();

    if (formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Future.delayed(const Duration(milliseconds: 300));
        if (!context.mounted) return;
        AuthUser user = AuthUser();
        Map<String, dynamic> responce = await user.loginUser(
          email: email,
          password: password,
        );
        await Future.delayed(const Duration(milliseconds: 300));
        if (!context.mounted) return;
        if (responce["success"] == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("auth_token", responce["token"]);
          print(responce["profile"]["location"]);
          if (!context.mounted) return;
          final provider = Provider.of<ProfileProvider>(context, listen: false);
          // provider.addProfile(
          //     profileinfo: Profileinfo.fromJson(responce["profile"]));
          SnakbarComp.showSnackBar(
            context,
            responce["message"],
          );
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ), (route) => false);
        } else {
          SnakbarComp.showSnackBar(
            context,
            responce["message"],
          );
        }
      } catch (e) {
        print(e);
        SnakbarComp.showSnackBar(
          context,
          "Some error accured!",
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;
      if (googleUser == null) {
        SnakbarComp.showSnackBar(context, "Select account");
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;

      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;
      SnakbarComp.showSnackBar(context, "Login In");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ),
        (route) => false,
      );
    } catch (e) {
      SnakbarComp.showSnackBar(context, "Some error accured!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 221, 231, 239),
            Color.fromARGB(255, 166, 186, 205),
          ])),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark),
            title: const Text("Login"),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () => signInWithGoogle(context),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.red, Colors.green, Colors.blue],
                            ).createShader(bounds);
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.google,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Continue with google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.blue,
                                Colors.lightBlue,
                                Colors.blue
                              ],
                            ).createShader(bounds);
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.facebook,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Continue with facebook",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return "Enter correct email";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Email",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    controller: _password,
                    obscureText: _isPasswordhidden,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter password";
                      } else if (value.length < 7) {
                        return "Enter minimum 8 character";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Password (min. 8 characters)",
                      suffixIcon: _isPasswordhidden
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordhidden = false;
                                });
                              },
                              icon: const Icon(Icons.visibility),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    _isPasswordhidden = true;
                                  },
                                );
                              },
                              icon: const Icon(Icons.visibility_off),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 20, right: 20, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(CupertinoModalPopupRoute(
                        builder: (context) {
                          return const ForgotPasswordScreen();
                        },
                      ));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () => userLogin(context),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.orange,
                        elevation: 0.4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            isLoading ? "Loading..." : "Sign in with email",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
