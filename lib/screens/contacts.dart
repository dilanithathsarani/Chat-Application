import 'package:chat_application/data/demo_data.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: DemoData.getDemoUsers().length,
        itemBuilder: (context, index) {
          final user = DemoData.getDemoUsers()[index];
          return ListTile(
            onTap: () {
              // Navigate to chat screen with the selected user
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
            leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
            title: Text(
              user.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}
