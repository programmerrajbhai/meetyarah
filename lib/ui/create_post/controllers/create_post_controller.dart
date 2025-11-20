import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // XFile এর জন্য
import 'package:http/http.dart' as http;
import 'package:meetyarah/data/clients/service.dart';
import 'package:meetyarah/data/utils/urls.dart';
import 'package:meetyarah/ui/home/controllers/get_post_controllers.dart';

import '../../login_reg_screens/controllers/auth_controller.dart';

class CreatePostController extends GetxController {
  final TextEditingController postTitleCtrl = TextEditingController();
  var isLoading = false.obs;

  final AuthService _authService = Get.find<AuthService>();

  // --- ফিক্স: List<XFile> এর বদলে List<dynamic> ব্যবহার করুন ---
  Future<void> createPost({List<dynamic>? images}) async {
    final String content = postTitleCtrl.text.trim();

    if (content.isEmpty && (images == null || images.isEmpty)) {
      Get.snackbar("Alert", "Please write something or add an image.", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isLoading(true);
      String? imageUrl;

      // ২. ছবি আপলোড
      if (images != null && images.isNotEmpty) {
        // dynamic হওয়ার কারণে .path এক্সেস করতে সমস্যা হবে না
        imageUrl = await _uploadImage(File(images.first.path));

        if (imageUrl == null) {
          isLoading(false);
          return;
        }
      }

      // ৩. পোস্ট তৈরি (API কল)
      networkResponse response = await networkClient.postRequest(
        url: Urls.createPostApi,
        body: {
          "post_content": content,
          "image_url": imageUrl,
        },
      );

      if (response.isSuccess && response.data['status'] == 'success') {
        Get.snackbar("Success", "Post created successfully!", snackPosition: SnackPosition.BOTTOM);

        postTitleCtrl.clear();

        // হোম পেজের ফিড রিফ্রেশ
        if (Get.isRegistered<GetPostController>()) {
          Get.find<GetPostController>().getAllPost();
        }

        Get.back();
      } else {
        // এরর মেসেজ হ্যান্ডলিং
        String msg = response.data != null ? (response.data['message'] ?? "Failed") : response.errorMessage ?? "Server Error";
        Get.snackbar("Error", msg, snackPosition: SnackPosition.BOTTOM);
      }

    } catch (e) {
      print("Create Post Error: $e");
      Get.snackbar("Error", "Something went wrong: $e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // ৪. ছবি আপলোড ফাংশন
  Future<String?> _uploadImage(File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(Urls.uploadImageApi));

      if (_authService.token.value.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer ${_authService.token.value}';
      }

      request.files.add(await http.MultipartFile.fromPath('image', file.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json != null && json['status'] == 'success') {
          return json['image_url'];
        } else {
          String msg = json != null ? (json['message'] ?? "Unknown error") : "Upload failed";
          Get.snackbar("Upload Failed", msg, snackPosition: SnackPosition.BOTTOM);
          return null;
        }
      } else {
        Get.snackbar("Error", "Image upload error: ${response.statusCode}", snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (e) {
      print("Upload Exception: $e");
      return null;
    }
  }
}