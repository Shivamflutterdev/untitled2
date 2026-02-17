import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post_model.dart';

class ApiService {

  static const baseUrl =
      "https://jsonplaceholder.typicode.com/posts";

  // READ
  static Future<List<Post>> fetchPosts() async {

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data.map((e) => Post.fromJson(e)).toList();

    } else {
      throw Exception("Failed to load posts");
    }
  }

  // CREATE
  static Future<Post> createPost(Post post) async {

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create post");
    }
  }

  // UPDATE
  static Future<Post> updatePost(Post post) async {

    final response = await http.put(
      Uri.parse("$baseUrl/${post.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update post");
    }
  }

  // DELETE
  static Future<bool> deletePost(int id) async {

    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),
    );

    return response.statusCode == 200;
  }
}
