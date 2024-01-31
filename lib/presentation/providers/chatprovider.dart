import 'package:flutter/material.dart';
import 'package:vivavox/services/chat/chat_service.dart';
import 'package:vivavox/services/model/chatinfo_model.dart';

class ChatProvider extends ChangeNotifier {
  List<Chatinfo> _allchats = [];
  List<Messagemodel> _chatmessages = [];

  bool _chatfetching = false;
  bool _messageadding = false;
  bool get chatfetching => _chatfetching;
  List<Chatinfo> get allchats => _allchats;
  List<Messagemodel> get chatmessages => _chatmessages;
  bool get messageadding => _messageadding;

  void setAllChats({required String email}) async {
    try {
      if (!_chatfetching) {
        _chatfetching = true;
        notifyListeners();
        Map<String, dynamic> res = await ChatService().fetchAllChat(
          email: email,
        );
        if (res["success"]) {
          List<dynamic> dynamicchatList = res["allchat"];
          List<Chatinfo> chatlist = dynamicchatList
              .map((x) => Chatinfo.fromJson(x))
              .toList()
              .cast<Chatinfo>();
          _allchats = chatlist;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    _chatfetching = false;
    notifyListeners();
  }

  void fetchPreviousChat({required String chatid}) async {
    try {
      if (!_chatfetching) {
        _chatfetching = true;
        notifyListeners();
        Map<String, dynamic> res = await ChatService().fetchChatMessages(
          chatid: chatid,
        );
        if (res["success"]) {
          List<dynamic> dynamicchatList = res["allchatmessages"];
          List<Messagemodel> messagelist = dynamicchatList
              .map((x) => Messagemodel.fromJson(x))
              .toList()
              .cast<Messagemodel>();
          _chatmessages = messagelist;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    _chatfetching = false;
    notifyListeners();
  }

  void addChat({required Map<String, dynamic> messgaejson}) async {
    _messageadding = true;
    notifyListeners();
    try {
      // await Future.delayed(Duration(seconds: 3));
      Map<String, dynamic> res = await ChatService().sendMessage(
        chat: messgaejson["chat"],
        message: messgaejson["message"],
        sender: messgaejson["sender"],
      );
      if (res["success"]) {
        dynamic newmessage = res["newmessage"];
        Messagemodel message = Messagemodel.fromJson(newmessage);
        _chatmessages.insert(0, message);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    _messageadding = false;
    notifyListeners();
  }
}
