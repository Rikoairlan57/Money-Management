import 'package:flutter/material.dart';
import 'decoration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 169, 76, 186),
      body: SafeArea(
          child: Center(
        child: textBig(text: "money"),
      )),
    );
  }
}
