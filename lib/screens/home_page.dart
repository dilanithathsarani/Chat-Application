import 'package:chat_application/data/demo_data.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/screens/contacts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu_rounded, color: Colors.white, size: 35),
                        Text(
                          'My Chat',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Icon(Icons.search, color: Colors.white, size: 35),
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
                              text: 'Kamal Bandara',
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
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: DemoData.demoConversations().length,
                itemBuilder: (context, index) {
                  final conversation = DemoData.demoConversations()[index];
                  return ListTile(
                    onTap: () {
                      // Navigate to chat screen with the selected conversation
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage(conversation.image),
                    ),
                    title: Text(
                      conversation.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(conversation.lastMessage),
                    trailing: Text(conversation.lastMessageTime),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
