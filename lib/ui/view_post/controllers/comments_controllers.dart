import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/data/clients/service.dart';
import '../../../data/utils/urls.dart';
import '../../home/controllers/get_post_controllers.dart';
import '../../login_reg_screens/controllers/auth_controller.dart';
import '../models/comments_model.dart';

class CommentController extends GetxController {
  final int postId;
  CommentController({required this.postId});

  var isLoading = false.obs;
  var comments = <CommentModel>[].obs;
  final TextEditingController commentTextController = TextEditingController();

  final AuthService _authService = Get.find<AuthService>();
  final GetPostController _postController = Get.find<GetPostController>();

  @override
  void onInit() {
    super.onInit();
    print("🔹 CommentController Init: PostID = $postId"); // 1. আইডি ঠিক আছে কি না
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      isLoading(true);

      String url = "${Urls.getCommentsApi}?post_id=$postId";
      print("🔹 API URL: $url"); // 2. ইউআরএল ঠিক আছে কি না

      networkResponse response = await networkClient.getRequest(url: url);

      print("🔹 Status Code: ${response.statusCode}"); // 3. সার্ভার রেসপন্স কোড
      print("🔹 Response Body: ${response.data}"); // 4. সার্ভার কী ডেটা পাঠাচ্ছে

      if (response.isSuccess && response.data?['status'] == 'success') {
        List<dynamic> data = response.data!['comments'];

        if (data.isEmpty) {
          print("🔸 Warning: Comment list is empty from server.");
        }

        comments.value = data.map((json) => CommentModel.fromJson(json)).toList();
        print("✅ Comments Loaded: ${comments.length}");
      } else {
        print("❌ API Error Message: ${response.errorMessage}");
      }
    } catch (e) {
      print("❌ Exception in fetchComments: $e"); // 5. কোডে কোনো ক্র্যাশ হচ্ছে কি না
    } finally {
      isLoading(false);
    }
  }

  Future<void> addComment() async {
    final text = commentTextController.text.trim();
    if (text.isEmpty) return;

    final int? myUserId = _authService.userId;
    if (myUserId == null) {
      Get.snackbar("Error", "Please login again.");
      return;
    }

    try {
      commentTextController.clear();
      FocusScope.of(Get.context!).unfocus();

      networkResponse response = await networkClient.postRequest(
        url: Urls.addCommentApi,
        body: {
          'post_id': postId,
          'user_id': myUserId,
          'comment_text': text,
        },
      );

      if (response.isSuccess && response.data?['status'] == 'success') {
        print("✅ Comment Added Success");
        await fetchComments(); // রিফ্রেশ

        // আপডেট কমেন্ট কাউন্ট
        // _postController.posts.firstWhere((p) => p.post_id == postId.toString()).comment_count;
        // (উপরের লাইনে একটু লজিক ফিক্স দরকার হতে পারে আপনার মডেল অনুযায়ী)

        Get.snackbar('Success', 'Comment added!');
      } else {
        print("❌ Add Comment Failed: ${response.data}");
        Get.snackbar('Error', 'Failed to add comment.');
      }
    } catch (e) {
      print("❌ Exception Add Comment: $e");
      Get.snackbar('Error', e.toString());
    }
  }
}