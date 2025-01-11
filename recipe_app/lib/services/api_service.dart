import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = 'c0d66d6c21e244c2913a84f41ad4a590';
  static const String _baseUrl = 'https://api.spoonacular.com';

  Future<List<dynamic>> fetchRecipes(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/recipes/complexSearch?query=$query&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<Map<String, dynamic>> fetchRecipeDetails(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/recipes/$id/information?apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }

  Future<List<dynamic>> fetchRecipesWithFilters(
    String query, {
    String? category,
    String? diet,
  }) async {
    final params = {
      'query': query,
      'apiKey': _apiKey,
      if (category != null) 'type': category,
      if (diet != null) 'diet': diet,
    };
    final uri = Uri.https(_baseUrl, '/recipes/complexSearch', params);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
