import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'post_controller.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  final PostController controller = Get.find<PostController>();

  late int id;

  @override
  void initState() {
    super.initState();

    // Get argument
    id = Get.arguments;

    // Call API only once
    controller.fetchPostById(id);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail"),
      ),

      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final post = controller.selectedPost.value;

        if (post == null) {
          return const Center(
            child: Text("No data"),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(post.body),

            ],
          ),
        );
      }),
    );
  }
}
