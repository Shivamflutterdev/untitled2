import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class ApiService {

  static const baseUrl =
      "https://jsonplaceholder.typicode.com/posts";

  // Get all posts
  static Future<List<Post>> getPosts() async {

    final response =
        await http.get(Uri.parse(baseUrl));

    final data = jsonDecode(response.body);

    return data.map<Post>((e) =>
        Post.fromJson(e)).toList();
  }

  // Get post by ID
  static Future<Post> getPostById(int id) async {

    final response =
        await http.get(Uri.parse("$baseUrl/$id"));

    final data = jsonDecode(response.body);

    return Post.fromJson(data);
  }
}
