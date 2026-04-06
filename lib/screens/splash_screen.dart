import 'dart:async';

import 'package:chat_application/providers/user_provider.dart';
import 'package:chat_application/screens/auth_screen.dart';
import 'package:chat_application/screens/home_page.dart';
import 'package:chat_application/utils/navigation_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        NavigationManager.goTo(context, AuthScreen());
      } else {
        Provider.of<UserProvider>(context, listen: false).fetchUserData(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 50,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text('From SUSL'),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset('assets/lotties/chat.json'),
            Text(
              'My Chat App',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
