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
      conversationId: json['conversationId'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      message: json['message'] as String? ?? '',
      time:
          (json['time'] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(0),
      messageId: json['messageId'] as String? ?? '',
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
