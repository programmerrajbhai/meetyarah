import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meetyarah/data/clients/service.dart'; // আপনার নেটওয়ার্ক ক্লায়েন্ট পাথ
import 'package:meetyarah/ui/home/screens/baseScreens.dart';
import '../../../data/utils/urls.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  final emailOrPhoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  // AuthService খুঁজে বের করি (এটি main.dart এ ইনজেক্ট করা থাকতে হবে)
  final AuthService _authService = Get.find<AuthService>();

  void LoginUser() async {
    String email = emailOrPhoneCtrl.text.trim();
    String password = passwordCtrl.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error!', "Please enter all fields", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Map<String, dynamic> requestBody = {
      "login_identifier": email, // আপনার API অনুযায়ী key
      "password": password,
    };

    try {
      // আপনার নেটওয়ার্ক কল (আপনার কোড অনুযায়ী)
      var response = await networkClient.postRequest(
        url: Urls.loginApi,
        body: requestBody,
      );

      // রেসপন্স হ্যান্ডলিং
      if (response.statusCode == 200 && response.data['status'] == 'success') {

        String token = response.data['token'];
        Map<String, dynamic> userData = response.data['user'];

        // --- টোকেন এবং ইউজার ডাটা সেভ করা ---
        await _authService.saveUserSession(token, userData);

        Get.snackbar('Success', "Login Successfully Done!", snackPosition: SnackPosition.BOTTOM);

        // সব পেজ রিমুভ করে হোম পেজে যাওয়া
        Get.offAll(() => const Basescreens());

      } else {
        Get.snackbar('Failed', "Invalid Credentials or Server Error", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }
}