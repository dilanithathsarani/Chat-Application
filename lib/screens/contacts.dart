import 'package:chat_application/controllers/user_controller.dart';
import 'package:chat_application/providers/chat_provider.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/utils/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: StreamBuilder(
        stream: UserController().getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                'No contacts found',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.image),
                ),
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () {
                  Provider.of<ChatProvider>(
                    context,
                    listen: false,
                  ).setSelectUser(user);
                  NavigationManager.goTo(context, ChatScreen());
                },
              );
            },
          );
        },
      ),
    );
  }
}
