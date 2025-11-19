import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meetyarah/ui/login_reg_screens/model/user_model.dart'; // আপনার UserModel ইমপোর্ট
import 'package:meetyarah/ui/login_reg_screens/screens/login_screen.dart';

class AuthService extends GetxService {
  late SharedPreferences _prefs;

  // ✅ এই লাইনটি মিসিং ছিল, এটি যোগ করুন
  // এটি ইউজারের সব তথ্য (নাম, ছবি) রিয়েল-টাইমে ধরে রাখবে
  final Rxn<UserModel> user = Rxn<UserModel>();

  final RxString token = ''.obs;

  Future<AuthService> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadUserSession();
    return this;
  }

  // --- 1. লগইন সেশন সেভ করা ---
  Future<void> saveUserSession(String userToken, Map<String, dynamic> userMap) async {
    await _prefs.setString('token', userToken);

    // ইউজার ম্যাপ থেকে মডেল তৈরি
    UserModel loggedInUser = UserModel.fromJson(userMap);

    // মডেলটিকে JSON String বানিয়ে সেভ করি যাতে পরে লোড করা যায়
    await _prefs.setString('user_data', jsonEncode(loggedInUser.toJson()));

    // ✅ অ্যাপের মেমোরিতে আপডেট করি (যাতে প্রোফাইল পেজ সাথে সাথে আপডেট হয়)
    token.value = userToken;
    user.value = loggedInUser;
  }

  // --- 2. ডাটা লোড করা (অটো লগইন) ---
  Future<void> _loadUserSession() async {
    final String? savedToken = _prefs.getString('token');
    final String? savedUserData = _prefs.getString('user_data');

    if (savedToken != null && savedToken.isNotEmpty) {
      token.value = savedToken;
    }

    if (savedUserData != null && savedUserData.isNotEmpty) {
      try {
        // ✅ সেভ করা ডাটা থেকে আবার ইউজার মডেল তৈরি করে মেমোরিতে রাখি
        user.value = UserModel.fromJson(jsonDecode(savedUserData));
      } catch (e) {
        print("Error loading user data: $e");
      }
    }
  }

  // --- 3. লগআউট ---
  Future<void> logout() async {
    await _prefs.clear();
    token.value = '';
    user.value = null;
    Get.offAll(() => const LoginScreen());
  }

  // চেক করি ইউজার লগইন আছে কি না
  bool get isLoggedIn => token.value.isNotEmpty;

  // শর্টকাট গেটার: ইউজার আইডি পাওয়ার জন্য
  // আপনার UserModel এ এটি String নাকি int তা চেক করে নেবেন
  String? get userId => user.value?.user_id;
}