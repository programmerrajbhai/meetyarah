import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meetyarah/data/clients/service.dart';
import 'package:meetyarah/ui/home/screens/baseScreens.dart';
import '../../../data/utils/urls.dart';

class LoginController extends GetxController {
  final emailOrPhoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void LoginUser() async {
    String email = emailOrPhoneCtrl.text.trim();
    String password = passwordCtrl.text.trim();

    if (email.isEmpty && password.isEmpty) {
      Get.snackbar(
        'Error!',
        "Please enter all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Map<String, dynamic> responseBody = {
        "login_identifier": emailOrPhoneCtrl.text.trim(),
        "password": passwordCtrl.text,
      };

      networkResponse response = await networkClient.postRequest(
        url: Urls.loginApi,
        body: responseBody,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          "Login Successfully Done!",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(Basescreens());
      } else {
        Get.snackbar(
          'faild',
          "Something went wrong!",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
