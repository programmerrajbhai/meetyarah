import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meetyarah/ui/login_reg_screens/screens/login_screen.dart'; // আপনার LoginScreen ইমপোর্ট করুন

class AuthService extends GetxService {
  late SharedPreferences _prefs;

  // সার্ভিস ইনিশিলাইজ করা
  Future<AuthService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // --- 1. লগইন সেশন সেভ করা ---
  Future<void> saveUserSession(String token, Map<String, dynamic> userMap) async {
    await _prefs.setString('token', token);
    await _prefs.setString('user_data', jsonEncode(userMap)); // পুরো ইউজার ডাটা সেভ
    await _prefs.setInt('user_id', userMap['user_id']); // কমেন্ট করার জন্য ID আলাদা সেভ করলাম
  }

  // --- 2. টোকেন আছে কিনা চেক করা (Auto Login এর জন্য) ---
  bool get isLoggedIn {
    return _prefs.getString('token') != null;
  }

  // --- 3. টোকেন গেট করা (API Call এর জন্য লাগবে) ---
  String? get token => _prefs.getString('token');

  // --- 4. ইউজার আইডি পাওয়া (কমেন্ট করার সময় লাগবে) ---
  int? get userId => _prefs.getInt('user_id');

  // --- 5. লগআউট ফাংশন ---
  Future<void> logout() async {
    await _prefs.clear(); // সব ডাটা মুছে ফেলবে
    Get.offAll(() => const LoginScreen()); // লগইন পেজে পাঠিয়ে দেবে
  }
}