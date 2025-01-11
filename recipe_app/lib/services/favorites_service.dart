import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _baseUrl = 'http://localhost:5000/api/favorites';

  Future<bool> addFavorite(int id, String title, String image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$_baseUrl/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      },
      body: json.encode({'id': id, 'title': title, 'image': image}),
    );

    return response.statusCode == 200;
  }

  Future<bool> removeFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$_baseUrl/remove'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      },
      body: json.encode({'id': id}),
    );

    return response.statusCode == 200;
  }

  Future<List<dynamic>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [];
    }
  }
}
