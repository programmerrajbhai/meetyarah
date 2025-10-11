import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/assetsPath/image_url.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/login_screen.dart';

import '../../../assetsPath/textColors.dart';
import '../widgets/Textfromfield.dart';
import '../widgets/containnerBox.dart';

class RegistrationScreens extends StatefulWidget {
  const RegistrationScreens({super.key});

  @override
  State<RegistrationScreens> createState() => _RegistrationScreensState();
}

class _RegistrationScreensState extends State<RegistrationScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ImagePath.appLogotransparent),
              textfromfield(icon: Icons.account_box, text: 'First Name'),
              SizedBox(height: 8),
              textfromfield(icon: Icons.account_box, text: 'Last Name'),
              SizedBox(height: 8),
              textfromfield(icon: Icons.email, text: 'Email Address'),
              SizedBox(height: 8),
              textfromfield(icon: Icons.lock, text: 'Password'),
              SizedBox(height: 8),

              SizedBox(height: 16),
              containnerBox(
                bgColors: ColorPath.deepBlue,
                text: "Registration",
                textColors: Colors.white,
              ),
              SizedBox(height: 14),
              Center(
                child: Text(
                  "-------------------------or-------------------------",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              SizedBox(height: 14),
              containnerBox(
                bgColors: Colors.white,
                text: 'Sign up by google',
                prefixIcons: ImagePath.gogoleIcon,
                textColors: Colors.black,
              ),
              SizedBox(height: 40),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Get.to(LoginScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
