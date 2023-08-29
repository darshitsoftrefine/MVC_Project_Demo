import 'dart:async';
import 'package:coupinos_project/views/constants/image_constants.dart';
import 'package:coupinos_project/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  String email = "";
  String password = "";

  @override
  void initState() {
    getEmail().then((value) {
        setState(() {
          email = value;
        });
      });
    super.initState();
    Timer(
        const Duration(seconds: 5),
            () =>Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())) );
  }
      Future<String> getEmail() async {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? obtainedEmail = sharedPreferences.getString('email');
      print(obtainedEmail);
      return obtainedEmail!;
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

