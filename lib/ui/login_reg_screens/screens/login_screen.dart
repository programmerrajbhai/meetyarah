import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/assetsPath/image_url.dart';
import 'package:meetyarah/assetsPath/textColors.dart';
import 'package:meetyarah/ui/login_reg_screens/controllers/loginController.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/forget_screen.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/reg_screen.dart';
import '../widgets/Textfromfield.dart';
import '../widgets/containnerBox.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার ইনিশিয়ালাইজ করা হলো
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  ImagePath.appLogotransparent,
                  height: Get.height * 0.25,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              textfromfield(
                icon: Icons.email,
                text: 'Email or Username',
                controller: loginController.emailOrPhoneCtrl,
              ),
              const SizedBox(height: 10),

              textfromfield(
                icon: Icons.lock,
                text: 'Password',
                controller: loginController.passwordCtrl,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotScreens());
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: ColorPath.deepBlue, fontSize: 14),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ✅ লগইন বাটন এবং লোডিং ইন্ডিকেটর
              Obx(() => loginController.isLoading.value
                  ? const Center(child: CircularProgressIndicator(color: ColorPath.deepBlue))
                  : containnerBox(
                onTap: () {
                  loginController.LoginUser(); // ফাংশন কল
                },
                bgColors: ColorPath.deepBlue,
                text: "LOGIN",
                textColors: Colors.white,
              )
              ),

              const SizedBox(height: 20),

              // অথবা গুগল সাইন ইন সেকশন
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('or', style: TextStyle(color: Colors.grey[600])),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
                ],
              ),

              const SizedBox(height: 20),

              containnerBox(
                bgColors: Colors.white,
                text: 'Sign in with Google',
                prefixIcons: ImagePath.gogoleIcon,
                textColors: Colors.black,
                onTap: (){
                  // গুগল সাইন ইন লজিক
                },
              ),

              const SizedBox(height: 30),

              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Colors.indigoAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const RegistrationScreens());
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}