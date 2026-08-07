import 'package:chat_application/models/conversation_model.dart';
import 'package:chat_application/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final sortedUids = List<String>.from(uids)..sort();
    return sortedUids.join('_');
  }

  Future<void> sendMessage(
    MessageModel message,
    ConversationModel conversation,
  ) async {
    await messageCollection.doc(message.messageId).set(message.toJson());
    await conversationCollection
        .doc(conversation.conversationId)
        .set(conversation.toJson(), SetOptions(merge: true));
  }

  Stream<List<MessageModel>> getMessages(String conId) {
    return messageCollection
        .where('conversationId', isEqualTo: conId).orderBy( 'time', descending: false)
        .snapshots()
        .map((message) {
          final messages = message.docs
              .map((e) => MessageModel.fromJson(e.data()))
              .toList();
          messages.sort((left, right) => right.time.compareTo(left.time));
          return messages;
        });
  }

  Stream<List<ConversationModel>> getConversations(String uid) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    return conversationCollection
        .where('userIds', arrayContains: myUid)
        .orderBy( 'lastMessageTime', descending: false)
        .snapshots()
        .map((snapshot) {
          final conversations = snapshot.docs
              .map((doc) => ConversationModel.fromJson(doc.data()))
              .toList();
          conversations.sort(
            (left, right) =>
                right.lastMessageTime.compareTo(left.lastMessageTime),
          );
          return conversations;
        });
  }
}
