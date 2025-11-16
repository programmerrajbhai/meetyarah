import 'package:get/get.dart';
import 'package:meetyarah/data/clients/service.dart';
import 'package:meetyarah/data/utils/urls.dart';
import 'package:meetyarah/ui/home/models/get_post_model.dart';

class GetPostController extends GetxController {

  var posts = <GetPostModel>[].obs;

  @override
  void onInit() {
    getAllPost();
    super.onInit();
  }

  Future<void> getAllPost() async {
    networkResponse response = await networkClient.getRequest(
      url: Urls.get_all_posts,
    );

    if (response.statusCode == 200 && response.data != null) {

      // response.data হচ্ছে পুরো JSON map
      // posts হচ্ছে একটি List<dynamic>
      final List data = response.data!['posts'];

      // Model convert
      posts.value = data.map((e) => GetPostModel.fromJson(e)).toList();

      // Console print
      print("Total Posts: ${posts.length}");
      print("First Post User: ${posts[0].username}");
      print("First Post Content: ${posts[0].post_content}");

      Get.snackbar("Success", "Loaded ${posts.length} posts");
    } else {
      Get.snackbar("Error", response.errorMessage ?? "Something went wrong");
    }
  }
}
