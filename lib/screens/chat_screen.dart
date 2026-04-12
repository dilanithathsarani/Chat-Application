import 'package:chat_application/controllers/chat_controller.dart';
import 'package:chat_application/providers/chat_provider.dart';
import 'package:chat_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).getSelectedConversation();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer2<ChatProvider, UserProvider>(
      builder: (context, chatProvider, userProvider, child) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: MediaQuery.of(context).viewInsets,

            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border(top: BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatProvider.messageController,
                        cursorColor: Colors.grey.shade800,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type Here...',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        chatProvider.sendMessage(context);
                      },
                      icon: Icon(Icons.send_rounded, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        chatProvider.selectedUser!.image,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatProvider.selectedUser!.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Online',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),

                Divider(),
                Expanded(
                  child: StreamBuilder(
                    stream: ChatController().getMessages(
                      chatProvider.generateConversationId(),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data == null) {
                        return Center(child: Text('No messages yet'));
                      }

                      if (snapshot.data != null && snapshot.data!.isEmpty) {
                        return Center(child: Text('No messages yet'));
                      }

                      final messages = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            bool isSender =
                                message.senderId == userProvider.user!.uid;

                            return Align(
                              alignment: isSender
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSender
                                      ? Colors.blue
                                      : Colors.grey.shade600,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  message.message,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
