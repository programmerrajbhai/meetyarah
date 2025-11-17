import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/data/clients/service.dart';

import '../../../data/utils/urls.dart';
import '../../home/controllers/get_post_controllers.dart';
import '../models/comments_model.dart';

class CommentController extends GetxController {
  // PostDetailPage থেকে postId রিসিভ করার জন্য
  final int postId;
  CommentController({required this.postId});

  var isLoading = false.obs;
  var comments = <CommentModel>[].obs; // কমেন্টের রি-অ্যাক্টিভ লিস্ট
  final TextEditingController commentTextController = TextEditingController();

  // PostController-কে খুঁজে নিই, যেন কমেন্ট কাউন্ট আপডেট করতে পারি
  final GetPostController _postController = Get.find<GetPostController>();

  @override
  void onInit() {
    super.onInit();
    fetchComments(); // পেজ চালু হওয়ামাত্রই কমেন্ট লোড করি
  }

  // API থেকে সব কমেন্ট লোড করার ফাংশন
  Future<void> fetchComments() async {
    try {
      isLoading(true);
      networkResponse response = await networkClient.getRequest(
        // get_comments.php-কে post_id পাঠাই
        url: "${Urls.getCommentsApi}?post_id=$postId",
      );
      if (response.isSuccess && response.data?['status'] == 'success') {
        List<dynamic> data = response.data!['comments'];
        comments.value = data.map((json) => CommentModel.fromJson(json)).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  // নতুন কমেন্ট যোগ করার ফাংশন
  Future<void> addComment() async {
    final text = commentTextController.text;
    if (text.isEmpty) return;

    try {
      // API-তে কল পাঠানোর আগে UI থেকে টেক্সট ক্লিয়ার করি এবং কি-বোর্ড হাইড করি
      commentTextController.clear();
      FocusScope.of(Get.context!).unfocus();

      networkResponse response = await networkClient.postRequest(
        url: Urls.addCommentApi,
        body: {
          'post_id': postId,
          'comment_text': text,
          // 'user_id' টোকেন থেকে আসবে, তাই পাঠানোর দরকার নেই
        },
      );

      if (response.isSuccess && response.data?['status'] == 'success') {
        // কমেন্ট যোগ সফল হলে, কমেন্ট লিস্ট রিফ্রেশ করি
        await fetchComments();

        // এবং হোম পেজের পোস্টের কমেন্ট কাউন্ট +১ করি
        // এটি একটি ভালো প্র্যাকটিস, যেন হোম পেজে ফেরত গেলে কাউন্ট ঠিক থাকে
        _postController.posts.firstWhere((p) => p.post_content == postId).comment_count;
        _postController.posts.refresh();
      } else {
        Get.snackbar('Error', 'Failed to add comment.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}