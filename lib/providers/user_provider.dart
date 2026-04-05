import 'package:chat_application/controllers/auth_controller.dart';
import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/screens/home_page.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> signInwithGoogle(BuildContext context) async {
    final user = await AuthController().signInWithGoogle();
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign in failed.Try again')));
    } else {
      _user = UserModel(
        image: user.photoURL ?? '',
        name: user.displayName ?? '',
        email: user.email ?? '',
        uid: user.uid,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  
}
