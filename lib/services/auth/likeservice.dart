import 'dart:convert';
import 'package:http/http.dart' as http;

class LikeService {
  // final String _baseUrl = "http://192.168.185.188:3000";
  final String _baseUrl = "https://vivavox-backend.vercel.app";

  Future<Map<String, dynamic>> likeUser({
    required String id,
    required String email,
    required bool issuperlike,
    required String remoteemail,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/likedislike/like"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'email': email,
          'issuperlike': issuperlike,
          'remoteemail': remoteemail,
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> dislikeUser({
    required String id,
    required String email,
    required String remoteemail,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/likedislike/dislike"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'email': email,
          'remoteemail': remoteemail,
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
