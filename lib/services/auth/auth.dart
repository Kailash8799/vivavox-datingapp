import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthUser {
  // final String _baseUrl = "http://192.168.185.188:3000";
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
      debugPrint('$e');
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> updateProfile(
      {required String email,
      required Map<String, dynamic> profiledata}) async {
    try {
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
      debugPrint('$e');
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> updateProfileImage(
      {required String email,
      required File image,
      required String? oldimage}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$_baseUrl/v1/users/updateprofileimage"));
      request.fields["email"] = email;
      request.fields["oldimage"] = oldimage ?? "";
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      request.headers.addAll({"Content-Type": "multipart/form-data"});
      final http.StreamedResponse res = await request.send();
      final http.Response response = await http.Response.fromStream(res);
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      debugPrint('$e');
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> deleteProfileImage(
      {required String email, required String oldimage}) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/updateprofileimage/delete"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'oldimage': oldimage,
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> uploadImages(
      {required String email,
      required File image,
      required List<String> oldimage}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$_baseUrl/v1/users/uploadimage"));
      request.fields["email"] = email;
      request.fields["oldimages"] = jsonEncode(oldimage);
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      request.headers.addAll({"Content-Type": "multipart/form-data"});
      final http.StreamedResponse res = await request.send();
      final http.Response response = await http.Response.fromStream(res);
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      debugPrint('$e');
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> deleteImages(
      {required String email, required String oldimage}) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/uploadimage/delete"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'oldimage': oldimage,
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }
}
