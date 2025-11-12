import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meetyarah/data/clients/service.dart';
import 'package:meetyarah/ui/home/screens/baseScreens.dart';
import 'package:meetyarah/ui/login_reg_screens/controllers/auth_controller.dart';
import 'package:meetyarah/ui/login_reg_screens/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

        LoginModel loginModel= LoginModel.fromJson(response.data! );
        // TODO: save token to local storage
        AuthController.saveUserInformation(loginModel.token, loginModel.userModel);





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
