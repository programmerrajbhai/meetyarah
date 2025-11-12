// import 'dart:convert';
//
// import 'package:meetyarah/ui/login_reg_screens/model/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthController {
//   static String? token;
//   static UserModel? userModel;
//   static String _tokenKey = 'token';
//   static String _userDataKey = 'user-data';
//
//   //Sae user Information
//   static Future<void> saveUserInformation(
//     String accessToken,
//     UserModel userModel,
//   ) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setString(_tokenKey, accessToken);
//     sharedPreferences.setString(_userDataKey, jsonEncode({userModel.toJson()}));
//     token = accessToken;
//     userModel = userModel;
//   }
//
//   //get user information
//   static Future<void> getUserInformation() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? accessToken = sharedPreferences.getString(_tokenKey);
//     String? saveUserModelString = sharedPreferences.getString(_userDataKey);
//
//     if (saveUserModelString != null) {
//       UserModel savedUserModel = UserModel.fromJson(
//         jsonDecode(saveUserModelString),
//       );
//       userModel = savedUserModel;
//     }
//
//     token = accessToken;
//   }
//
//   //check if user already logged in
//   static Future<bool> checkUserLoggedIn() async {
//     SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
//     String? userAccessToken= sharedPreferences.getString(_tokenKey);
//
//     if(userAccessToken!= null){
//       await getUserInformation();
//       return true;
//     }else return false;
//
//   }
// }
import 'dart:convert';
import 'package:meetyarah/ui/login_reg_screens/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;

  static const String _tokenKey = 'token';
  static const String _userDataKey = 'user-data';

  /// ✅ Save user information (token + user)
  static Future<void> saveUserInformation(
      String accessToken,
      UserModel user,
      ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, accessToken);
    await prefs.setString(_userDataKey, jsonEncode(user.toJson()));

    token = accessToken;
    AuthController.userModel = user; // ✅ proper assignment
  }

  /// ✅ Get user info from SharedPreferences
  static Future<void> getUserInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString(_tokenKey);

    final String? userJson = prefs.getString(_userDataKey);
    if (userJson != null) {
      try {
        final Map<String, dynamic> decoded = jsonDecode(userJson);
        AuthController.userModel = UserModel.fromJson(decoded);
      } catch (e) {
        print("⚠️ Failed to decode user data: $e");
      }
    }
  }

  /// ✅ Check if user logged in
  static Future<bool> checkUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedToken = prefs.getString(_tokenKey);

    if (storedToken != null && storedToken.isNotEmpty) {
      await getUserInformation();
      return true;
    }
    return false;
  }

  /// ✅ Logout / Clear
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token = null;
    userModel = null;
  }
}
