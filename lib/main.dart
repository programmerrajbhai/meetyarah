import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home:  LoginScreen(),

    );
  }
}
