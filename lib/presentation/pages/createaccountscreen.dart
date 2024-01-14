import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vivavox/presentation/pages/loginscreen.dart';
import 'package:vivavox/presentation/pages/splashscreen.dart';
import 'package:vivavox/presentation/widgets/snakbar.dart';

class Createaccountscreen extends StatefulWidget {
  const Createaccountscreen({super.key});

  @override
  State<Createaccountscreen> createState() => _CreateaccountscreenState();
}

class _CreateaccountscreenState extends State<Createaccountscreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> createAccount(BuildContext context) async {
    String email = _email.text.trim();
    String password = _password.text;
    if (formkey.currentState!.validate()) {
      try {
        await Future.delayed(const Duration(seconds: 1));
        if (!context.mounted) return;

        await Future.delayed(const Duration(seconds: 1));
        if (!context.mounted) return;
        SnakbarComp.showSnackBar(
          context,
          "Account has been created",
        );
        Navigator.of(context).pushReplacement(
          CupertinoModalPopupRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ),
        );
      } catch (e) {
        SnakbarComp.showSnackBar(
          context,
          "Some error accured!",
        );
      }
    }
  }

  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;

      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;
      SnakbarComp.showSnackBar(context, "Login In");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const Splashscreen();
          },
        ),
        (route) => false,
      );
    } catch (e) {
      SnakbarComp.showSnackBar(
        context,
        "Some error accured!",
      );
    }
  }

  static bool _isPasswordhidden = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 10, 57, 102),
            Color.fromARGB(255, 4, 16, 27),
          ])),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: const Text("Create an account"),
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
                      onPressed: () => signUpWithGoogle(context),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.white,
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
                                  colors: [
                                    Colors.red,
                                    Colors.green,
                                    Colors.blue
                                  ]).createShader(bounds);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.google,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Sign up with google",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.white,
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
                                  colors: [
                                    Colors.blueAccent,
                                    Colors.blue,
                                    Colors.blue
                                  ]).createShader(bounds);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.facebook,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Sign up with facebook",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      disabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
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
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: ElevatedButton(
                      onPressed: () => createAccount(context),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor:
                              const Color.fromARGB(255, 33, 90, 143),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Text(
                              "Sign up with email",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
                  child: Text(
                    "If you click \"Continue with Google\" and are not a Deep Music user, you will be registered and you agree to Deep Music's Term&Conditions and Privacy Policy.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 129, 142, 155),
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                  child: Text(
                    "We may use your email and devices for updates tips on Depp Music's products and services, and for activities notification settings.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 129, 142, 155),
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
                  child: Text(
                    "We may use informations you provide us in order to show you targeted ads as described in our Privacy Policy.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 129, 142, 155),
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
