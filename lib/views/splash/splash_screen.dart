import 'dart:async';

import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ConstantImages.splashBackgroundImage, fit: BoxFit.fill, height: double.infinity,),
          Center(child: Image.asset(ConstantImages.splashTextImage, width: 228, height: 48.23, fit: BoxFit.fill,)),
        ],
      ),
    );
  }
}
