import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vivavox/presentation/pages/createaccountscreen.dart';
import 'package:vivavox/presentation/pages/loginscreen.dart';
import 'package:vivavox/presentation/pages/termandcondition.dart';
import 'package:vivavox/presentation/widgets/animation/pagetransaction.dart';
import 'package:vivavox/skeleton/imageskeleton.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  static const List<String> images = [
    "https://images.unsplash.com/photo-1599624588451-a2c6c4d5fe3a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbWFnZXxlbnwwfHwwfHx8MA%3D%3D",
    "https://images.unsplash.com/photo-1541823709867-1b206113eafd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzV8fGdpcmwlMjBpbWFnZXxlbnwwfHwwfHx8MA%3D%3D",
    "https://images.unsplash.com/photo-1503342394128-c104d54dba01?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjZ8fGdpcmwlMjBpbWFnZXxlbnwwfHwwfHx8MA%3D%3D"
  ];

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool showFirst = true;
  bool checkMark = false;
  late TapGestureRecognizer _termsConditionRecognizer;

  void gotoTermandConditions() {
    Navigator.of(context).push(AnimationTransition(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Termandcondition();
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    _termsConditionRecognizer = TapGestureRecognizer()
      ..onTap = () {
        gotoTermandConditions();
      };
  }

  @override
  void dispose() {
    _termsConditionRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            setState(() {
              showFirst = !showFirst;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.heart_broken,
                          color: Colors.red,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                            "Vivavox",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        )
                      ]),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Card(
                        elevation: 0.3,
                        color: Colors.transparent,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AnimatedCrossFade(
                              firstChild: CachedNetworkImage(
                                height: 350,
                                width: 170,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return const Imageskeleton(
                                    height: 350.0,
                                    width: 170.0,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return const Imageskeleton(
                                    height: 350.0,
                                    width: 170.0,
                                  );
                                },
                                imageUrl: Splashscreen.images[0],
                              ),
                              secondChild: CachedNetworkImage(
                                height: 350,
                                width: 170,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return const Imageskeleton(
                                    height: 350.0,
                                    width: 170.0,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return const Imageskeleton(
                                    height: 350.0,
                                    width: 170.0,
                                  );
                                },
                                imageUrl: Splashscreen.images[1],
                              ),
                              crossFadeState: showFirst
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(seconds: 2),
                            )),
                      ),
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 0.3,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AnimatedCrossFade(
                                  firstChild: CachedNetworkImage(
                                    height: 170,
                                    width: 140,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return const Imageskeleton(
                                        height: 170.0,
                                        width: 140.0,
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Imageskeleton(
                                        height: 170.0,
                                        width: 140.0,
                                      );
                                    },
                                    imageUrl: Splashscreen.images[1],
                                  ),
                                  secondChild: CachedNetworkImage(
                                    height: 170,
                                    width: 140,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return const Imageskeleton(
                                        height: 170.0,
                                        width: 140.0,
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Imageskeleton(
                                        height: 170.0,
                                        width: 140.0,
                                      );
                                    },
                                    imageUrl: Splashscreen.images[2],
                                  ),
                                  crossFadeState: showFirst
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(seconds: 4))),
                        ),
                        Card(
                          elevation: 0.3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AnimatedCrossFade(
                              firstChild: CachedNetworkImage(
                                height: 170,
                                width: 140,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return const Imageskeleton(
                                    height: 170.0,
                                    width: 140.0,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return const Imageskeleton(
                                    height: 170.0,
                                    width: 140.0,
                                  );
                                },
                                imageUrl: Splashscreen.images[2],
                              ),
                              secondChild: CachedNetworkImage(
                                height: 170,
                                width: 140,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return const Imageskeleton(
                                    height: 170.0,
                                    width: 140.0,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return const Imageskeleton(
                                    height: 170.0,
                                    width: 140.0,
                                  );
                                },
                                imageUrl: Splashscreen.images[0],
                              ),
                              crossFadeState: showFirst
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(seconds: 4),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 6, top: 20),
                  child: Text(
                    "Enjoy the new exprience of chating with global friend",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      height: 1,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 6, top: 10),
                  child: Text(
                    "Connect people arround the world for free. Go beyond your social circle & connect with people near and far.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      height: 1,
                      fontFamily: 'Afacad',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(AnimationTransition(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const LoginScreen();
                          },
                          opaque: false,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.orange,
                        elevation: 0.4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(AnimationTransition(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const Createaccountscreen();
                          },
                          opaque: false,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.grey,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Signup",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 0, top: 10),
                  child: RichText(
                    text: TextSpan(
                      text: "By tapping \"continue or sign in\", you ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        height: 1,
                        fontFamily: 'Afacad',
                      ),
                      children: [
                        TextSpan(
                          text: "agree to our Terms.",
                          recognizer: _termsConditionRecognizer,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: "Learn how we process your data in our",
                        ),
                        TextSpan(
                          text: " privacy policy",
                          recognizer: _termsConditionRecognizer,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: " and"),
                        TextSpan(
                          text: " Cookies Policy",
                          recognizer: _termsConditionRecognizer,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
