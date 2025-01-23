import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'c0d66d6c21e244c2913a84f41ad4a590';

// Function to fetch recipes from Spoonacular API
Future<List<dynamic>> fetchRecipes() async {
  final response = await http.get(
    Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&number=10',
    ),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to load recipes');
  }
}

// Example usage
void main() async {
  List<dynamic> recipes = await fetchRecipes();
  print(recipes);
}
