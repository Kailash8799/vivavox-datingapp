import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnakbarComp {
  static void showSnackBar(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     showCloseIcon: true,
    //     closeIconColor: Colors.white,
    //     backgroundColor: const Color.fromARGB(255, 26, 84, 138),
    //     content: Text(
    //       message,
    //       style: const TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // );
  }
}
