import 'package:flutter/material.dart';
import 'package:untitled2/data/controller.dart';
import 'package:untitled2/data/model.dart';


class UserView extends StatelessWidget {
  UserView({Key? key}) : super(key: key);

  final UserController controller = Get.put(UserController());

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void clearFields() {
    nameController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX SQLite CRUD"),
      ),
      body: Column(
        children: [

          /// INPUT
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    controller.addUser(
                      nameController.text,
                      emailController.text,
                    );
                    clearFields();
                  },
                  child: Text("Add User"),
                )
              ],
            ),
          ),

          /// LIST
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount:
                    controller.userList.length,
                itemBuilder: (context, index) {
                  User user =
                      controller.userList[index];

                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),

                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [

                        /// UPDATE
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            nameController.text =
                                user.name;
                            emailController.text =
                                user.email;

                            controller.updateUser(
                              User(
                                id: user.id,
                                name:
                                    nameController.text,
                                email:
                                    emailController.text,
                              ),
                            );
                          },
                        ),

                        /// DELETE
                        IconButton(
                          icon:
                              Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteUser(
                                user.id!);
                          },
                        ),
                      ],
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
