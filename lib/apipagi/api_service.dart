import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {

  static const String baseUrl =
      "https://jsonplaceholder.typicode.com/users";

  /// GET USERS
  Future<List<User>> fetchUsers(int page) async {

    final response = await http.get(
      Uri.parse("$baseUrl?_page=$page&_limit=5"),
    );

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data.map((e) =>
          User.fromJson(e)).toList();

    }

    throw Exception("Failed to fetch users");
  }

  /// ADD USER
  Future<void> addUser(User user) async {

    await http.post(
      Uri.parse(baseUrl),
      body: user.toJson(),
    );

  }

  /// UPDATE USER
  Future<void> updateUser(User user) async {

    await http.put(
      Uri.parse("$baseUrl/${user.id}"),
      body: user.toJson(),
    );

  }

  /// DELETE USER
  Future<void> deleteUser(int id) async {

    await http.delete(
      Uri.parse("$baseUrl/$id"),
    );

  }

}