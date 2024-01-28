import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vivavox/presentation/widgets/snakbar.dart';
import 'package:vivavox/services/auth/auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _email = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> forgotPassword(BuildContext context) async {
    final String email = _email.text.trim();

    if (formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Future.delayed(const Duration(seconds: 1));
        if (!context.mounted) return;
        AuthUser user = AuthUser();
        Map<String, dynamic> responce = await user.resetPassword(
          email: email,
        );
        await Future.delayed(const Duration(seconds: 1));
        if (!context.mounted) return;
        if (responce["success"] == true) {
          SnakbarComp.showSnackBar(
            context,
            responce["message"],
          );
          Navigator.of(context).pop();
        } else {
          SnakbarComp.showSnackBar(
            context,
            responce["message"],
          );
        }
      } catch (e) {
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
            title: const Text("Forgot passoword"),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Form(
            key: formkey,
            child: Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
                  child: Text(
                    "If you forgot your password then send reset password request. You got email click on link then reset your password in website.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 129, 142, 155),
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
                  child: ElevatedButton(
                    onPressed: () => forgotPassword(context),
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
                            isLoading ? "Loading..." : "Reset password",
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
