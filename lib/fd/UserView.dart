import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';
import 'user_model.dart';

class UserView extends StatelessWidget {

  UserView({super.key});

  final controller =
  Get.put(UserController());

  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final startIdController =
  TextEditingController();

  final endIdController =
  TextEditingController();

  final startDateController =
  TextEditingController();

  final endDateController =
  TextEditingController();

  int? editingId;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("CRUD + Pagination + Date Filter"),
      ),

      body: Column(
        children: [

          /// ADD USER
          TextField(
            controller: nameController,
            decoration:
            InputDecoration(labelText: "Name"),
          ),

          TextField(
            controller: emailController,
            decoration:
            InputDecoration(labelText: "Email"),
          ),

          ElevatedButton(
            onPressed: () {

              controller.addUser(
                nameController.text,
                emailController.text,
              );

            },
            child: Text("Add User"),
          ),

          /// ID FILTER
          Row(
            children: [

              Expanded(
                child: TextField(
                  controller: startIdController,
                  decoration:
                  InputDecoration(labelText: "Start ID"),
                ),
              ),

              Expanded(
                child: TextField(
                  controller: endIdController,
                  decoration:
                  InputDecoration(labelText: "End ID"),
                ),
              ),

              ElevatedButton(
                onPressed: () {

                  controller.applyIdFilter(

                    int.parse(startIdController.text),
                    int.parse(endIdController.text),

                  );

                },
                child: Text("ID Filter"),
              )

            ],
          ),

          /// DATE FILTER
          Row(
            children: [

              Expanded(
                child: TextField(
                  controller: startDateController,
                  decoration:
                  InputDecoration(
                    labelText: "Start Date YYYY-MM-DD",
                  ),
                ),
              ),

              Expanded(
                child: TextField(
                  controller: endDateController,
                  decoration:
                  InputDecoration(
                    labelText: "End Date YYYY-MM-DD",
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {

                  controller.applyDateFilter(

                    startDateController.text,
                    endDateController.text,

                  );

                },
                child: Text("Date Filter"),
              )

            ],
          ),

          ElevatedButton(
            onPressed: controller.clearFilter,
            child: Text("Clear Filter"),
          ),

          /// LIST
          Expanded(
            child: Obx(() {

              return Column(
                children: [

                  Expanded(
                    child: ListView.builder(

                      itemCount:
                      controller.userList.length,

                      itemBuilder: (context, index) {

                        User user =
                        controller.userList[index];

                        return ListTile(

                          title: Text(user.name),

                          subtitle:
                          Text("${user.email} | ${user.date}"),

                          trailing: IconButton(

                            icon: Icon(Icons.delete),

                            onPressed: () {

                              controller.deleteUser(user.id!);

                            },

                          ),

                        );

                      },

                    ),
                  ),

                  if (controller.hasMore.value)
                    ElevatedButton(
                      onPressed: controller.loadMore,
                      child: Text("Load More"),
                    ),

                  if (controller.isLoading.value)
                    CircularProgressIndicator(),

                ],
              );

            }),
          )

        ],
      ),

    );

  }

}