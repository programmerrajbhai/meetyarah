import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:meetyarah/data/clients/service.dart';
import 'package:meetyarah/data/utils/urls.dart';
import 'package:meetyarah/ui/home/controllers/get_post_controllers.dart';
import 'package:meetyarah/ui/login_reg_screens/controllers/auth_controller.dart';


class CreatePostController extends GetxController {
  final TextEditingController postTitleCtrl = TextEditingController();
  var isLoading = false.obs;

  // AuthService খুঁজে বের করি
  final AuthService _authService = Get.find<AuthService>();

  Future<void> createPost({List<dynamic>? images}) async {
    final String content = postTitleCtrl.text.trim();

    if (content.isEmpty && (images == null || images.isEmpty)) {
      Get.snackbar("Alert", "Please write something or add an image.", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isLoading(true);
      String? imageUrl;

      if (images != null && images.isNotEmpty) {
        // প্রথম ছবিটি আপলোড করি
        imageUrl = await _uploadImage(File(images.first.path));

        // আপলোড ব্যর্থ হলে থামুন
        if (imageUrl == null) {
          isLoading(false);
          return;
        }
      }

      // পোস্ট তৈরি (API কল)
      networkResponse response = await networkClient.postRequest(
        url: Urls.createPostApi, // ✅ এটি Urls.dart এ থাকতে হবে
        body: {
          "post_content": content,
          "image_url": imageUrl,
        },
      );

      if (response.isSuccess && response.data != null && response.data['status'] == 'success') {
        Get.snackbar("Success", "Post created successfully!", snackPosition: SnackPosition.BOTTOM);

        postTitleCtrl.clear();

        // হোম পেজ রিফ্রেশ
        if (Get.isRegistered<GetPostController>()) {
          Get.find<GetPostController>().getAllPost();
        }

        Get.back();
      } else {
        String msg = "Failed";
        if (response.data != null) {
          msg = response.data['message'] ?? "Unknown Error";
        } else {
          msg = response.errorMessage ?? "Server Connection Failed";
        }
        Get.snackbar("Error", msg, snackPosition: SnackPosition.BOTTOM);
      }

    } catch (e) {
      print("Create Post Error: $e");
      Get.snackbar("Error", "Something went wrong", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<String?> _uploadImage(File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(Urls.uploadImageApi)); // ✅ এটি Urls.dart এ থাকতে হবে

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
          Get.snackbar("Upload Failed", json['message'] ?? "Unknown error");
          return null;
        }
      }

      if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized! Please login again.", snackPosition: SnackPosition.BOTTOM);
        return null;
      }
      return null;
    } catch (e) {
      print("Upload Exception: $e");
      return null;
    }
  }
}