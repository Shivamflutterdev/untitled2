import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'user_model.dart';

class HomeScreen extends StatelessWidget {

  final FirestoreService service = FirestoreService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Firebase CRUD")),

      body: Column(

        children: [

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

                    service.addUser(
                      nameController.text,
                      emailController.text,
                    );

                    nameController.clear();
                    emailController.clear();

                  },
                  child: Text("Add User"),
                ),

              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<List<UserModel>>(

              stream: service.getUsers(),

              builder: (context, snapshot) {

                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                var users = snapshot.data!;

                return ListView.builder(

                  itemCount: users.length,

                  itemBuilder: (context, index) {

                    var user = users[index];

                    return ListTile(

                      title: Text(user.name),
                      subtitle: Text(user.email),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {

                              service.updateUser(
                                user.id,
                                "Updated Name",
                                "updated@email.com",
                              );

                            },
                          ),

                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              service.deleteUser(user.id);
                            },
                          ),

                        ],
                      ),

                    );

                  },

                );

              },

            ),
          )

        ],

      ),

    );

  }

}