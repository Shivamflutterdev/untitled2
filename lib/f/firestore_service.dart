import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class FirestoreService {

  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  // CREATE
  Future<void> addUser(String name, String email) async {

    await users.add({
      'name': name,
      'email': email,
    });

  }

  // READ
  Stream<List<UserModel>> getUsers() {

    return users.snapshots().map((snapshot) {

      return snapshot.docs.map((doc) {

        return UserModel.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );

      }).toList();

    });

  }

  // UPDATE
  Future<void> updateUser(
      String id, String name, String email) async {

    await users.doc(id).update({
      'name': name,
      'email': email,
    });

  }

  // DELETE
  Future<void> deleteUser(String id) async {

    await users.doc(id).delete();

  }

}