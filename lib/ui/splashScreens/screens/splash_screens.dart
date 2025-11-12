import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/ui/home/screens/baseScreens.dart';
import 'package:meetyarah/ui/login_reg_screens/controllers/auth_controller.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay\

    final bool isLoggedIn= await AuthController.checkUserLoggedIn();

    if(isLoggedIn== true){
      Get.to(Basescreens());
    }else{
      Get.to(LoginScreen());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // your theme color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔷 App logo or image
            Image.asset(
              'assets/logo.png', // replace with your logo
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome to MeetYarah",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
