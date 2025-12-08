import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/clients/service.dart';
import '../../../data/utils/urls.dart';
import '../screens/login_screen.dart';

class RegistrationController extends GetxController {
  final firstnameCtrl = TextEditingController();
  final lastnameCtrl = TextEditingController(); // এটি Username হিসেবে ব্যবহার হচ্ছে
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  // ✅ লোডিং স্টেট ভেরিয়েবল
  var isLoading = false.obs;

  Future<void> RegisterUser() async {
    String fullName = firstnameCtrl.text.trim();
    String username = lastnameCtrl.text.trim();
    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();

    if (fullName.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Warning',
        "Please fill all fields properly",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // ✅ লোডিং শুরু
      isLoading.value = true;

      Map<String, dynamic> responseBody = {
        "full_name": fullName,
        "username": username,
        "email": email,
        "password": password,
      };

      print("🔹 Registering user: $email");

      networkResponse response = await networkClient.postRequest(
        url: Urls.registerApi,
        body: responseBody,
      );

      print("🔹 Response: ${response.statusCode} - ${response.data}");

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        Get.snackbar(
          'Success',
          "Registration Successful! Please Login.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // সব ফিল্ড ক্লিয়ার করা
        firstnameCtrl.clear();
        lastnameCtrl.clear();
        emailCtrl.clear();
        passwordCtrl.clear();

        // ✅ লগইন স্ক্রিনে পাঠিয়ে দেওয়া
        Get.off(() => const LoginScreen());

      } else {
        Get.snackbar(
          'Failed',
          response.data['message'] ?? "Registration failed. Try different email/username.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("❌ Registration Error: $e");
      Get.snackbar(
        'Error',
        "Something went wrong. Check internet connection.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      // ✅ লোডিং শেষ (সফল বা ব্যর্থ যাই হোক)
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstnameCtrl.dispose();
    lastnameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }
}