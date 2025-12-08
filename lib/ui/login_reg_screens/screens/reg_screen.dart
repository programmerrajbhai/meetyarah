import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/assetsPath/image_url.dart';
import 'package:meetyarah/ui/login_reg_screens/controllers/registrationController.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/login_screen.dart';

import '../../../assetsPath/textColors.dart';
import '../widgets/Textfromfield.dart';
import '../widgets/containnerBox.dart';

class RegistrationScreens extends StatelessWidget {
  const RegistrationScreens({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার ইনিশিয়ালাইজেশন
    final RegistrationController _regcontroller = Get.put(
      RegistrationController(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- লোগো সেকশন ---
                Center(
                  child: Image.asset(
                    ImagePath.appLogotransparent,
                    height:
                        120, // হাইট ফিক্স করা হয়েছে যাতে সব স্ক্রিনে সুন্দর দেখায়
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),

                // --- হেডার টেক্সট ---
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  "Sign up to get started!",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // --- ইনপুট ফিল্ড ---
                textfromfield(
                  icon: Icons.person,
                  text: 'Full Name',
                  controller: _regcontroller.firstnameCtrl,
                ),
                const SizedBox(height: 12),

                textfromfield(
                  icon: Icons.alternate_email, // ইউজারনেমের জন্য আইকন
                  text: 'Username',
                  controller: _regcontroller.lastnameCtrl,
                ),
                const SizedBox(height: 12),

                textfromfield(
                  icon: Icons.email_outlined,
                  text: 'Email Address',
                  controller: _regcontroller.emailCtrl,
                ),
                const SizedBox(height: 12),

                textfromfield(
                  icon: Icons.lock_outline,
                  text: 'Password',
                  controller: _regcontroller.passwordCtrl,
                ),

                const SizedBox(height: 24),

                // --- রেজিস্টার বাটন (উইথ লোডিং) ---
                Obx(
                  () => _regcontroller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: ColorPath.deepBlue,
                          ),
                        )
                      : containnerBox(
                          onTap: () {
                            // কিবোর্ড নামিয়ে দেওয়া
                            FocusScope.of(context).unfocus();
                            _regcontroller.RegisterUser();
                          },
                          bgColors: ColorPath.deepBlue,
                          text: "SIGN UP",
                          textColors: Colors.white,
                        ),
                ),

                const SizedBox(height: 20),

                // --- অথবা (OR Divider) ---
                Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[300]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey[300]),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- গুগল সাইন আপ ---
                containnerBox(
                  bgColors: Colors
                      .white, // বর্ডার থাকলে ভালো দেখাবে যদি কন্টেইনারে বর্ডার থাকে
                  text: 'Sign up with Google',
                  prefixIcons: ImagePath.gogoleIcon,
                  textColors: Colors.black87,
                  onTap: () {
                    // Google Sign up logic here
                  },
                ),

                const SizedBox(height: 30),

                // --- লগইন লিংক ---
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: ColorPath.deepBlue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.off(() => const LoginScreen());
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
      ),
    );
  }
}
