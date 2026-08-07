import 'package:chat_application/controllers/auth_controller.dart';
import 'package:chat_application/controllers/user_controller.dart';
import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/screens/auth_screen.dart';
import 'package:chat_application/screens/home_page.dart';
import 'package:chat_application/utils/navigation_manager.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> signInwithGoogle(BuildContext context) async {
    final user = await AuthController().signInWithGoogle();
    if (!context.mounted) return;

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

      await UserController().saveUserData(_user!);

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  Future<void> fetchUserData(BuildContext context) async {
    _user = await UserController().fetchUserData();
    if (!context.mounted) return;
    if (_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to fetch user data',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      NavigationManager.goWithReplace(context, HomePage());
    }
  }

  Future<void> signOutUser(BuildContext context) async {
    _user = null;
    await AuthController().signOutGoogleUser();
    if (!context.mounted) return;
    NavigationManager.goWithReplace(context, AuthScreen());
  }
}
