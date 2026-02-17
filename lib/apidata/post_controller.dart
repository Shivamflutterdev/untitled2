import 'package:get/get.dart';
import '../model/post_model.dart';
import '../service/api_service.dart';

class PostController extends GetxController {

  var postList = <Post>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {

    isLoading.value = true;

    try {
      final posts = await ApiService.fetchPosts();
      postList.assignAll(posts);
    } finally {
      isLoading.value = false;
    }
  }

  void addPost(Post post) async {

    final newPost = await ApiService.createPost(post);

    postList.insert(0, newPost);
  }

  void updatePost(Post post) async {

    final updated = await ApiService.updatePost(post);

    int index =
        postList.indexWhere((e) => e.id == post.id);

    if (index != -1) {
      postList[index] = updated;
    }
  }

  void deletePost(int id) async {

    bool success = await ApiService.deletePost(id);

    if (success) {
      postList.removeWhere((e) => e.id == id);
    }
  }
}
