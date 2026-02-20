import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';
import 'user_model.dart';

class UserView extends StatefulWidget {

  const UserView({super.key});

  @override
  State<UserView> createState() =>
      _UserViewState();

}

class _UserViewState extends State<UserView> {

  final controller = Get.put(UserController());

  final scrollController = ScrollController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  int? editingUserId;

  @override
  void initState() {

    super.initState();

    controller.fetchUsers();

    scrollController.addListener(() {

      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          controller.hasMore.value) {

        controller.fetchUsers(loadMore: true);

      }

    });

  }

  @override
  void dispose() {

    scrollController.dispose();
    nameController.dispose();
    emailController.dispose();

    super.dispose();

  }

  void saveUser() {

    String name = nameController.text;
    String email = emailController.text;

    if (editingUserId == null) {

      controller.addUser(name, email);

    } else {

      controller.updateUser(
        User(
          id: editingUserId!,
          name: name,
          email: email,
        ),
      );

      editingUserId = null;

    }

    nameController.clear();
    emailController.clear();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("GetX Full CRUD Pagination"),
      ),

      body: Column(

        children: [

          Padding(

            padding: EdgeInsets.all(10),

            child: Column(

              children: [

                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: saveUser,
                  child: Text(
                    editingUserId == null
                        ? "Add User"
                        : "Update User",
                  ),
                ),

              ],

            ),

          ),

          Expanded(

            child: Obx(() {

              if (controller.isLoading.value) {

                return Center(
                  child: CircularProgressIndicator(),
                );

              }

              return ListView.builder(

                controller: scrollController,

                itemCount:
                controller.userList.length +
                    (controller.isPaginationLoading.value ? 1 : 0),

                itemBuilder: (context, index) {

                  if (index ==
                      controller.userList.length) {

                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      ),
                    );

                  }

                  User user =
                  controller.userList[index];

                  return ListTile(

                    title: Text(user.name),

                    subtitle: Text(user.email),

                    leading: IconButton(

                      icon: Icon(Icons.edit),

                      onPressed: () {

                        nameController.text =
                            user.name;

                        emailController.text =
                            user.email;

                        editingUserId =
                            user.id;

                      },

                    ),

                    trailing: IconButton(

                      icon: Icon(Icons.delete),

                      onPressed: () {

                        controller.deleteUser(
                            user.id);

                      },

                    ),

                  );

                },

              );

            }),

          )

        ],

      ),

    );

  }

}