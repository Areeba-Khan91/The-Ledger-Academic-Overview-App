import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  // READ
  static Future<List<dynamic>> getCourses() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception("Failed to load");
  }

  // CREATE
  static Future<bool> addCourse(String title, String body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
    );
    return response.statusCode == 201;
  }

  // UPDATE
  static Future<bool> updateCourse(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      body: jsonEncode({'id': id, 'title': title, 'body': body, 'userId': 1}),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
    );
    return response.statusCode == 200;
  }

  // DELETE
  static Future<bool> deleteCourse(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }
}