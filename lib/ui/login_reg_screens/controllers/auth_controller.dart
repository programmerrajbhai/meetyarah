import 'dart:convert';

import 'package:meetyarah/ui/login_reg_screens/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;
  static String _tokenKey = 'token';
  static String _userDataKey = 'user-data';

  //Sae user Information
  static Future<void> saveUserInformation(
    String accessToken,
    UserModel userModel,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(_userDataKey, jsonEncode({userModel.toJson()}));
    token = accessToken;
    userModel = userModel;
  }

  //get user information
  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? saveUserModelString = sharedPreferences.getString(_userDataKey);

    if (saveUserModelString != null) {
      UserModel savedUserModel = UserModel.fromJson(
        jsonDecode(saveUserModelString),
      );
      userModel = savedUserModel;
    }

    token = accessToken;
  }

  //check if user already logged in
  static Future<bool> checkUserLoggedIn() async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? userAccessToken= sharedPreferences.getString(_tokenKey);

    if(userAccessToken!= null){
      await getUserInformation();
      return true;
    }else return false;

  }
}
