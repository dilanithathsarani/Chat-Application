import 'package:chat_application/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  String lastMessage;
  DateTime lastMessageTime;
  String senderId;
  List<String> userIds;
  List<UserModel> userData;
  String conversationId;

  ConversationModel({
    required this.lastMessage,
    required this.lastMessageTime,
    required this.senderId,
    required this.userIds,
    required this.userData,
    required this.conversationId,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    final users = (json['userData'] as List<dynamic>? ?? const [])
        .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();

    return ConversationModel(
      lastMessage: json['lastMessage'],
      lastMessageTime: (json['lastMessageTime'] as Timestamp).toDate(),
      senderId: json['senderId'],
      userIds: (json['userIds'] as List<dynamic>).map((e) => e as String).toList(),
      userData: users,
      conversationId: json['conversationId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastMessage': lastMessage,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'senderId': senderId,
      'userIds': userIds,
      'userData': userData.map((e) => e.toJson()),
      'conversationId': conversationId,
    };
  }
}
