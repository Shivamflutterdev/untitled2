import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'post_controller.dart';

class PostDetailScreen extends StatelessWidget {

  final controller =
      Get.find<PostController>();

  @override
  Widget build(BuildContext context) {

    final int id = Get.arguments;

    controller.fetchPostById(id);

    return Scaffold(

      appBar:
          AppBar(title: Text("Post Detail")),

      body: Obx(() {

        if (controller.isLoading.value) {
          return Center(
              child:
              CircularProgressIndicator());
        }

        final post =
            controller.selectedPost.value;

        if (post == null) {
          return Text("No data");
        }

        return Padding(
          padding:
              EdgeInsets.all(16),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                post.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(post.body),
            ],
          ),
        );
      }),
    );
  }
}
