import 'package:get/get.dart';
import 'package:meetyarah/data/clients/service.dart';
import 'package:meetyarah/data/utils/urls.dart';
import 'package:meetyarah/ui/home/models/get_post_model.dart';

class GetPostController extends GetxController {
  var posts = <GetPostModel>[].obs;
  var isLoading = true.obs; // লোডিং স্ট্যাটাস ট্র্যাক করার জন্য

  @override
  void onInit() {
    getAllPost();
    super.onInit();
  }

  Future<void> getAllPost() async {
    try {
      isLoading(true); // ডেটা লোড শুরু হলে লোডিং ট্রু হবে

      networkResponse response = await networkClient.getRequest(
        url: Urls.get_all_posts,
      );

      if (response.statusCode == 200 && response.data != null) {
        final List data = response.data!['posts'];
        posts.value = data.map((e) => GetPostModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", response.errorMessage ?? "Something went wrong");
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false); // কাজ শেষ হলে লোডিং ফলস হবে
    }
  }
}