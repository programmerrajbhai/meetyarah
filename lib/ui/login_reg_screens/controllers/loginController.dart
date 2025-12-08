import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/data/clients/service.dart';
import 'package:meetyarah/ui/home/screens/baseScreens.dart';
import '../../../data/utils/urls.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  final emailOrPhoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  var isLoading = false.obs;

  // AuthService খুঁজে বের করা
  final AuthService _authService = Get.find<AuthService>();

  Future<void> LoginUser() async {
    String email = emailOrPhoneCtrl.text.trim();
    String password = passwordCtrl.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Warning',
        "Please enter both email and password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading(true);

      Map<String, dynamic> requestBody = {
        "login_identifier": email,
        "password": password,
      };

      print("🔹 Logging in with: $email"); // Debugging Log

      networkResponse response = await networkClient.postRequest(
        url: Urls.loginApi,
        body: requestBody,
      );

      print("🔹 API Response: ${response.statusCode} - ${response.data}"); // Debugging Log

      if (response.statusCode == 200 && response.data['status'] == 'success') {

        String token = response.data['token'];
        Map<String, dynamic> userData = response.data['user'];

        // AuthService-এ ডাটা সেভ করা
        await _authService.saveUserSession(token, userData);

        Get.snackbar(
          'Success',
          "Login Successfully Done!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // ইনপুট ক্লিয়ার করা
        emailOrPhoneCtrl.clear();
        passwordCtrl.clear();

        // হোম পেজে যাওয়া
        Get.offAll(() => const Basescreens());

      } else {
        Get.snackbar(
          'Login Failed',
          response.data['message'] ?? "Invalid Email or Password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("❌ Login Error: $e");
      Get.snackbar(
        'Error',
        "Connection Error. Check Internet or IP.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}