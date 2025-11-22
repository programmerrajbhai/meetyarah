import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/get_post_controllers.dart';
import '../controllers/like_controller.dart'; // ✅ ১. LikeController ইমপোর্ট
import '../../view_post/screens/post_details.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final postController = Get.put(GetPostController());
  final likeController = Get.put(LikeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await postController.getAllPost();
          },
          color: Colors.blue,
          child: Obx(() {
            if (postController.isLoading.value) {
              return _buildFacebookShimmerEffect();
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // ---------------- Story Section ----------------
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          storyCard("Create Story", "https://picsum.photos/200"),
                          ...List.generate(
                            5,
                                (i) => storyCard("Story $i", "https://picsum.photos/30$i"),
                          ),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
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
                                      "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.full_name ?? "Unknown User",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        post.created_at ?? "",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.more_vert),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Post Content
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


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [


                                  LikeButton(
                                    isLiked: post.isLiked,
                                    likeCount: post.like_count ?? 0,
                                    onTap: () {
                                      // ইনডেক্স পাঠিয়ে লাইক টগল করা হচ্ছে
                                      postController.toggleLike(index);
                                    },
                                  ),

                                  // কমেন্ট বাটন
                                  interactionButton(
                                    Icons.comment,
                                    "${post.comment_count} Comments",
                                    onTap: () {
                                      Get.to(() => PostDetailPage(post: post));
                                    },
                                  ),
// ৩. শেয়ার বাটন
                                  interactionButton(
                                    Icons.share,
                                    "Share",
                                    onTap: () {
                                      // আপনার সার্ভার আইপি এবং পোস্ট আইডি দিয়ে লিংক তৈরি
                                      // ⚠️ আপনার আইপি ঠিক আছে তো? android manifest এর সাথে মিল থাকতে হবে
                                      String postLink = "http://192.168.1.112/post?id=${post.post_id}";

                                      // Bottom Sheet ওপেন করা
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                        ),
                                        builder: (context) {
                                          return Container(
                                            padding: const EdgeInsets.all(20),
                                            height: 200,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Share this post",
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(height: 20),

                                                // 🔗 অপশন ১: লিংক কপি করা
                                                ListTile(
                                                  leading: const Icon(Icons.copy),
                                                  title: const Text("Copy Link"),
                                                  onTap: () {
                                                    Clipboard.setData(ClipboardData(text: postLink));
                                                    Get.back(); // মেনু বন্ধ
                                                    Get.snackbar("Success", "Link copied to clipboard!");
                                                  },
                                                ),

                                                // 📤 অপশন ২: শেয়ার করা
                                                ListTile(
                                                  leading: const Icon(Icons.share),
                                                  title: const Text("Share via..."),
                                                  onTap: () {
                                                    Get.back();
                                                    Share.share("Check out this post: $postLink");
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),    ],
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
      ),
    );
  }

  // ---------------- Helper Widgets ----------------

  Widget _buildFacebookShimmerEffect() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 120, height: 10, color: Colors.white),
                        const SizedBox(height: 5),
                        Container(width: 80, height: 10, color: Colors.white),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Container(width: double.infinity, height: 10, color: Colors.white),
                const SizedBox(height: 5),
                Container(width: double.infinity, height: 10, color: Colors.white),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget storyCard(String name, String img) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
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

  Widget interactionButton(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black54),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// ✅ অ্যানিমেটেড লাইক বাটন উইজেট
// ==========================================
class LikeButton extends StatefulWidget {
  final bool isLiked;
  final int likeCount;
  final VoidCallback onTap;

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.likeCount,
    required this.onTap,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant LikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLiked && !oldWidget.isLiked) {
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ১. বাউন্স অ্যানিমেশন
        _controller.forward().then((_) => _controller.reverse());
        // ২. কন্ট্রোলারের ফাংশন কল
        widget.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // আইকন স্কেল অ্যানিমেশন
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                widget.isLiked ? Icons.favorite : Icons.favorite_border,
                color: widget.isLiked ? Colors.red : Colors.black54,
                size: 24,
              ),
            ),
            const SizedBox(width: 6),
            // টেক্সট কালার আপডেট
            Text(
              "${widget.likeCount} Likes",
              style: TextStyle(
                fontSize: 14,
                color: widget.isLiked ? Colors.red : Colors.black87,
                fontWeight: widget.isLiked ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}