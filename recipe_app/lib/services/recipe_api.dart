import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipe.dart';

class RecipeApi {
  static const String apiKey = 'c0d66d6c21e244c2913a84f41ad4a590';
  static const String apiUrl =
      'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&number=20';

  static Future<List<Recipe>> fetchRecipes(String query) async {
    final response = await http.get(Uri.parse('$apiUrl&query=$query'));
    print('API Response: ${response.body}'); // Log the API response

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  static Future<Recipe> fetchRecipeDetails(int id) async {
    final response = await http.get(
      Uri.parse(
        'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey',
      ),
    );
    print('Recipe Details Response: ${response.body}'); // Log the API response

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }
}
