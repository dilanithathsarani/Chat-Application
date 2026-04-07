import 'package:chat_application/controllers/chat_controller.dart';
import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/models/conversation_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ChatProvider extends ChangeNotifier {
  UserModel? _selectedUser;
  UserModel? get selectedUser => _selectedUser;

  ConversationModel? _selectedConversation;
  ConversationModel? get selectedConversation => _selectedConversation;

  TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  void setSelectUser(UserModel user) {
    _selectedUser = user;
    _selectedConversation = null;
    notifyListeners();
  }

  Future<void> sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      // Implementation for sending message
    }
  }

  Future<void> getSelectedConversation() async {
    if(_selectedConversation==null){
      final myUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    // Implementation for getting selected conversation
    _selectedConversation = await ChatController().getExistingConversation(
      [_selectedUser!.uid, myUid],
    );
    Logger().i(_selectedConversation?.conversationId);
    }
  }
}
