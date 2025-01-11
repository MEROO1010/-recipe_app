import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/api_service.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  bool _loading = false;

  List<Recipe> get recipes => _recipes;
  bool get loading => _loading;

  Future<void> fetchRecipes(
    String query, {
    String? category,
    String? diet,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      _recipes =
          (await ApiService().fetchRecipes(
            query,
          )).map((data) => Recipe.fromJson(data)).toList();
    } catch (error) {
      _recipes = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
