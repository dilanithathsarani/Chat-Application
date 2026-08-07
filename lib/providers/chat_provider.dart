import 'package:chat_application/controllers/chat_controller.dart';
import 'package:chat_application/models/message_model.dart';
import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/models/conversation_model.dart';
import 'package:chat_application/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  UserModel? _selectedUser;
  UserModel? get selectedUser => _selectedUser;

  ConversationModel? _selectedConversation;
  ConversationModel? get selectedConversation => _selectedConversation;

  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  void setSelectUser(UserModel user) {
    _selectedUser = user;
    _selectedConversation = null;
    notifyListeners();
  }

  void setSelectedConversation(ConversationModel conversation) {
    _selectedConversation = conversation;
    _selectedUser = conversation.userData.firstWhere(
      (userData) => userData.uid != FirebaseAuth.instance.currentUser!.uid,
    );
    notifyListeners();
  }

  Future<void> sendMessage(BuildContext context) async {
    final messageId = Uuid().v4();
    final myUserModel = Provider.of<UserProvider>(context, listen: false).user!;
    final receiverUserModel =
        _selectedUser ??
        _selectedConversation!.userData.firstWhere(
          (userData) => userData.uid != myUserModel.uid,
        );
    if (_messageController.text.trim().isEmpty) {
      // Implementation for sending message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Write your message',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      final message = MessageModel(
        conversationId: generateConversationId(),
        senderId: FirebaseAuth.instance.currentUser!.uid,
        message: _messageController.text.trim(),
        time: DateTime.now(),
        messageId: messageId,
      );

      final conversation = ConversationModel(
        lastMessage: message.message,
        conversationId: message.conversationId,
        lastMessageTime: message.time,
        senderId: message.senderId,
        userData: [myUserModel, receiverUserModel],
        userIds: message.conversationId.split('_'),
      );

      await ChatController().sendMessage(message, conversation);
      _messageController.clear();
    }
  }

  Future<void> getSelectedConversation() async {
    if (_selectedConversation == null && _selectedUser != null) {
      final myUid = FirebaseAuth.instance.currentUser?.uid ?? '';
      _selectedConversation = await ChatController().getExistingConversation([
        _selectedUser!.uid,
        myUid,
      ]);
      Logger().i(_selectedConversation?.conversationId);
    }
  }

  String generateConversationId() {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    final receiverUid = _selectedUser != null
        ? _selectedUser!.uid
        : _selectedConversation!.userIds.firstWhere((uid) => uid != myUid);
    List<String> uids = [myUid, receiverUid];
    uids.sort();
    return uids.join('_');
  }
}
