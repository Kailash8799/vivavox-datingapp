import 'package:vivavox/services/model/profileinfo.dart';

class Chatinfo {
  final String chatid;
  final LikesUser user1;
  final LikesUser user2;
  final Messagemodel? latestMessage;

  Chatinfo({
    required this.chatid,
    required this.user1,
    required this.user2,
    this.latestMessage,
  });

  factory Chatinfo.fromJson(Map<String, dynamic> json) {
    return Chatinfo(
      chatid: json["_id"].toString(),
      user1: LikesUser.fromJson(json["userid"]),
      user2: LikesUser.fromJson(json["remoteuser"]),
      latestMessage: json["latestMessage"] == null
          ? null
          : Messagemodel.fromJson(json["latestMessage"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "chatid": chatid,
        "user1": user1,
        "user2": user2,
        "latestMessage": latestMessage,
      };
}

class Messagemodel {
  final String messageid;
  final String chatid;
  final String senderid;
  final String message;
  final DateTime messagetime;

  Messagemodel({
    required this.messageid,
    required this.chatid,
    required this.senderid,
    required this.message,
    required this.messagetime,
  });

  factory Messagemodel.fromJson(Map<String, dynamic> json) {
    return Messagemodel(
      messageid: json["_id"],
      chatid: json["chat"].toString(),
      senderid: json["sender"],
      message: json["message"],
      messagetime: DateTime.parse(json["createdAt"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "messageid": messageid,
        "chatid": chatid,
        "senderid": senderid,
        "message": message,
        "messagetime": messagetime,
      };
}
