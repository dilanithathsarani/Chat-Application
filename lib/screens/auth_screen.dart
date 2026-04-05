import 'package:chat_application/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sign In to My Chat App',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
            Text('Connect with My Chat App'),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).signInwithGoogle(context);
              },
              child: Image.asset('assets/images/google_button.png', height: 60),
            ),
          ],
        ),
      ),
    );
  }
}
