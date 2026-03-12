import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(child: SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text('From SUSL')),
      )),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          LottieBuilder.asset('assets/lotties/chat.json'),
            Text(
              'My Chat App',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}