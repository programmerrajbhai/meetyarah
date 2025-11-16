import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_post_controllers.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  final postController = Get.put(GetPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {

          /// Loading state
          if (postController.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                // ---------------- Story Section ----------------
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10

                  ),
                  child: SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        storyCard("Create Story", "https://picsum.photos/200"),
                        ...List.generate(
                          5,
                              (i) => storyCard("Story $i", "https://picsum.photos/30$i"),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // ---------------- Posts Section ----------------
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: postController.posts.length,
                    itemBuilder: (context, index) {
                      final post = postController.posts[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // User Info Row
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: post.profile_picture_url != null
                                      ? NetworkImage(post.profile_picture_url!)
                                      : const NetworkImage(
                                      "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                                  ),
                                ),
                                const SizedBox(width: 10),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.username ?? "Unknown User",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      post.created_at ?? "",
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),

                                const Spacer(),
                                const Icon(Icons.more_vert),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Post Content Text
                            if (post.post_content != null)
                              Text(
                                post.post_content!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                            const SizedBox(height: 10),

                            // Post Image
                            if (post.image_url != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  post.image_url!,
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            const SizedBox(height: 10),

                            // Likes + Comments
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                interactionButton(Icons.favorite_border, "${post.like_count} Likes"),
                                interactionButton(Icons.comment, "${post.comment_count} Comments"),
                                interactionButton(Icons.share, "Share"),
                              ],
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ---------------- Helper Widgets ----------------

  Widget storyCard(String name, String img) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
            ),
          ),
        ),
      ),
    );
  }

  Widget interactionButton(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
