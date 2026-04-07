import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String conversationId;
  String senderId;
  String message;
  DateTime time;
  String messageId;

  MessageModel({
    required this.conversationId,
    required this.senderId,
    required this.message,
    required this.time,
    required this.messageId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      message: json['message'],
      time: (json['time'] as Timestamp).toDate(),
      messageId: json['messageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'senderId': senderId,
      'message': message,
      'time': Timestamp.fromDate(time),
      'messageId': messageId,
    };
  }
}