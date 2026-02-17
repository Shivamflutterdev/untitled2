import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'post_controller.dart';
import 'post_detail_screen.dart';

class PostListScreen extends StatelessWidget {

  final controller =
      Get.put(PostController());

  @override
  Widget build(BuildContext context) {

    controller.fetchPosts();

    return Scaffold(

      appBar:
          AppBar(title: Text("Posts")),

      body: Obx(() {

        if (controller.isLoading.value) {
          return Center(
              child:
              CircularProgressIndicator());
        }

        return ListView.builder(

          itemCount:
              controller.postList.length,

          itemBuilder:
              (context, index) {

            final post =
                controller.postList[index];

            return ListTile(

              title:
                  Text(post.title),

              onTap: () {

                // PASS ID
                Get.to(
                  () => PostDetailScreen(),
                  arguments: post.id,
                );
              },
            );
          },
        );
      }),
    );
  }
}
