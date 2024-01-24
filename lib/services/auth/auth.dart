import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthUser {
  final String _baseUrl = "https://vivavox-backend.vercel.app";
  Future<Map<String, dynamic>> createUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/signin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> getProfile({
    required String token,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/getprofile"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'token': token}),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> logOut() async {
    try {
      final SharedPreferences status = await SharedPreferences.getInstance();
      await status.remove("auth_token");
      return {"success": true, "message": "Logout"};
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> getAllProfile({
    required String email,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/getallprofile"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> resetPassword({required String email}) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/forgot/sendemail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      print(e);
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> updateProfile(
      {required String email,
      required Map<String, dynamic> profiledata}) async {
    try {
      // print(profiledata);
      final profiled = jsonEncode(<String, dynamic>{
        'email': email,
        'profile': profiledata,
      });
      print(profiled);
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/editprofile"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'profile': profiledata,
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      print(e);
      return {"success": false, "message": "Some error occurred!"};
    }
  }
}
