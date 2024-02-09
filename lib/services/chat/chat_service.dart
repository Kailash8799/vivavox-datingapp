import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService {
  // final String _baseUrl = "http://192.168.8.207:3000";
  final String _baseUrl = "https://vivavox.up.railway.app";
  // final String _baseUrl = "https://vivavox-backend.vercel.app";

  Future<Map<String, dynamic>> createChat({
    required String id,
    required String email,
    required String remoteemail,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/chatroom/createchat"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
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

  Future<Map<String, dynamic>> sendMessage({
    required String chat,
    required String sender,
    required String message,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/chatroom/addmessage"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'chat': chat,
          'sender': sender,
          'message': message,
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> fetchAllChat({
    required String email,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/chatroom/getallchat"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      debugPrint(e.toString());
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> fetchChatMessages({
    required String chatid,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/chatroom/getallmessage"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'chatid': chatid,
        }),
      );
      Map<String, dynamic> data =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      return data;
    } catch (e) {
      debugPrint(e.toString());
      return {"success": false, "message": "Some error occurred!"};
    }
  }

  Future<Map<String, dynamic>> deleteChat({
    required String id,
    required String email,
    required String remoteemail,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$_baseUrl/v1/users/chatroom/deletechat"),
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
