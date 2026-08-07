import 'package:chat_application/providers/user_provider.dart';
import 'package:chat_application/providers/chat_provider.dart';
import 'package:chat_application/controllers/chat_controller.dart';
import 'package:chat_application/models/conversation_model.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/screens/contacts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<ChatProvider, UserProvider>(
      builder: (context, chatProvider, userProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactScreen()),
              );
            },

            child: Icon(Icons.people),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.menu_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              'My Chat',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      userProvider.user?.image.isNotEmpty ==
                                          true
                                      ? NetworkImage(userProvider.user!.image)
                                      : null,
                                  child:
                                      userProvider.user?.image.isNotEmpty ==
                                          true
                                      ? null
                                      : Icon(
                                          Icons.person,
                                          color: Colors.blueGrey,
                                        ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    userProvider.signOutUser(context);
                                  },
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              text: 'Hello ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: userProvider.user?.name,
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 20, bottom: 15),
                child: Text(
                  'Recent Chats',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<ConversationModel>>(
                  stream: ChatController().getConversations(
                    userProvider.user!.uid,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Failed to load chats'));
                    }

                    final conversations = snapshot.data ?? [];
                    if (conversations.isEmpty) {
                      return Center(child: Text('No recent chats yet'));
                    }

                    return MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: conversations.length,
                        itemBuilder: (context, index) {
                          final conversation = conversations[index];
                          final otherUser = conversation.userData.firstWhere(
                            (userData) =>
                                userData.uid != userProvider.user!.uid,
                          );

                          return ListTile(
                            onTap: () {
                              chatProvider.setSelectedConversation(
                                conversation,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: otherUser.image.isNotEmpty
                                  ? NetworkImage(otherUser.image)
                                  : null,
                              child: otherUser.image.isNotEmpty
                                  ? null
                                  : Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              otherUser.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(conversation.lastMessage),
                            trailing: Text(
                              DateFormat('hh:mm a').format(conversation.lastMessageTime),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
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
        );
      },
    );
  }
}
