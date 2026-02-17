

import 'package:get/get.dart';
import 'post_model.dart';
import 'api_service.dart';

class PostController extends GetxController {

  var postList = <Post>[].obs;
  var selectedPost = Rxn<Post>();

  var isLoading = false.obs;

  // Fetch list
  void fetchPosts() async {

    isLoading.value = true;

    final data =
        await ApiService.getPosts();

    postList.assignAll(data);

    isLoading.value = false;
  }

  // Fetch single post using ID
  void fetchPostById(int id) async {

    isLoading.value = true;

    final post =
        await ApiService.getPostById(id);

    selectedPost.value = post;

    isLoading.value = false;
  }
}
