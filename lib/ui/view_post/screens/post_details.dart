import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetyarah/ui/home/models/get_post_model.dart';

import '../controllers/comments_controllers.dart';
import '../models/comments_model.dart';
import '../widgets/post_card.dart';

class PostDetailPage extends StatelessWidget {
  final GetPostModel post;

  PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    CommentController controller = Get.put(
      CommentController(postId: post.user_id ?? 0),
    );

    const Color darkBlue = Color(0xFF1B1B3C);
    const Color mediumBlue = Color(0xFF2A2A4A);

    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        title: Text(post.full_name ?? "Unknown User"),
        backgroundColor: mediumBlue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // পোস্ট কার্ড
          PostCard(
            post: post,
            isDetailPage: true,
          ),

          // সব কমেন্ট লিস্ট
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.comments.isEmpty) {
                return Center(
                  child: Text(
                    "No comments yet.",
                    style: TextStyle(color: Colors.white54),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  final CommentModel comment = controller.comments[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            comment.profilePictureUrl ??
                                'https://i.pravatar.cc/150?img=5',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: mediumBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.fullName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  comment.commentText,
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),

          // কমেন্ট ইনপুট ফিল্ড
          _buildCommentInput(context, mediumBlue, controller),
        ],
      ),
    );
  }

  Widget _buildCommentInput(
      BuildContext context,
      Color backgroundColor,
      CommentController controller,
      ) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8 + MediaQuery.of(context).viewInsets.bottom,
      ),
      color: backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.commentTextController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blueAccent),
            onPressed: controller.addComment,
          )
        ],
      ),
    );
  }
}
