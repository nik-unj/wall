import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wall/auth/auth.dart';
import 'package:wall/strings/strings.dart';
import 'package:wall/style/styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/wall.jpg'),
          ),
        ),
        child: Center(
          child: Container(
            height: 200,
            width: 200,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.white54),
            child: Text(
              Strings.wall,
              textAlign: TextAlign.center,
              style: CustomStyle.blackConcertBold(50).copyWith(height: 1),
            ),
          ),
        ),
      ),
    );
  }
}
