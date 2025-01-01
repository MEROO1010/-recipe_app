import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipe.dart';

class RecipeApi {
  static const String apiKey = 'db585db8c4c1401d8e9b4154f09073c6';
  static const String apiUrl =
      'https://api.spoonacular.com/recipes/random?number=10&apiKey=$apiKey';

  static Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['recipes'];
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
