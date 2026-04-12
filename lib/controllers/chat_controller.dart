import 'package:chat_application/models/conversation_model.dart';
import 'package:chat_application/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class ChatController {
  final conversationCollection = FirebaseFirestore.instance.collection(
    'Conversations',
  );

  final messageCollection = FirebaseFirestore.instance.collection('Messages');

  Future<ConversationModel?> getExistingConversation(List<String> uids) async {
    final data = await conversationCollection
        .doc(generateConversationId(uids))
        .get();
    if (data.exists) {
      final conversation = ConversationModel.fromJson(
        data.data() as Map<String, dynamic>,
      );
      Logger().e(conversation.conversationId);
      return conversation;
    } else {
      Logger().i('No existing conversation found for uids: $uids');
      return null;
    }
  }

  String generateConversationId(List<String> uids) {
    uids.sort();
    return uids.join('_');
  }

  Future<void> sendMessage(
    MessageModel message,
    ConversationModel conversation,
  ) async {
    await messageCollection.doc(message.messageId).set(message.toJson());
    await conversationCollection.doc(conversation.conversationId).set({
      'lastMessage': message.message,
      'lastMessageTime': message.time,
    });
  }

  Stream<List<MessageModel>> getMessages(String conId) {
    return messageCollection
        .where('conversationId', isEqualTo: conId)
        .orderBy('time', descending: true)
        .snapshots()
        .map((message) {
          return message.docs
              .map((e) => MessageModel.fromJson(e.data()))
              .toList();
        });
  }
}
