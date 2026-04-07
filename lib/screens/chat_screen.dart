import 'package:chat_application/providers/chat_provider.dart';
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
    Provider.of<ChatProvider>(
      context,
      listen: false,
    ).getSelectedConversation();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
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
                    SizedBox(
                      width: size.width * 0.7,
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
                        chatProvider.sendMessage();
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
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Hello'),
                        subtitle: Text('How are you?'),
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
