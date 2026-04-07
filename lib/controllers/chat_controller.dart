import 'package:chat_application/models/conversation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController {
  final conversationCollection = FirebaseFirestore.instance.collection(
    'Conversations',
  );

  Future<ConversationModel?> getExistingConversation(
    List<String> uids,
  ) async {
    final data = await conversationCollection
        .where('userIds', arrayContains: uids[0])
        .where('userIds', arrayContains: uids[1])
        .get();
    if (data.docs.isNotEmpty) {
      final conversation = ConversationModel.fromJson(data.docs[0].data());
      return conversation;
    } else {
      return null;
    }
  }
}
