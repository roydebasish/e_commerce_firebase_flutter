import 'dart:async';

import 'package:e_commerce_firebase_flutter/utils/color.dart';
import 'package:e_commerce_firebase_flutter/utils/config.dart';
import 'package:e_commerce_firebase_flutter/views/HomeScreen/home_screent.dart';
import 'package:e_commerce_firebase_flutter/views/WelcomeScreen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../BottomNavBarView/bottom_navbarview.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final user = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => user != null ? const BottomNavBarView() : WelcomeScreen()), (route) => false);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Text(AppConfig.appName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
