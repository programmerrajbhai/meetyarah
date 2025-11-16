import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/ui/home/screens/baseScreens.dart';
import 'package:meetyarah/ui/home/screens/feed_screen.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/login_screen.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/reg_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
      theme: ThemeData.light(),
    );
  }
}
