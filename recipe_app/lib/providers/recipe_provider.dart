import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/api_service.dart';

class RecipeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Recipe> _recipes = [];
  Recipe? _selectedRecipe;
  bool _isLoading = false;

  List<Recipe> get recipes => _recipes;
  Recipe? get selectedRecipe => _selectedRecipe;
  bool get isLoading => _isLoading;

  Future<void> fetchPopularRecipes() async {
    _isLoading = true;
    notifyListeners();
    _recipes =
        (await _apiService.fetchPopularRecipes())
            .map((json) => Recipe.fromJson(json))
            .toList();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchRecipes(String query) async {
    _isLoading = true;
    notifyListeners();
    _recipes =
        (await _apiService.searchRecipes(
          query,
        )).map((json) => Recipe.fromJson(json)).toList();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRecipeDetails(int id) async {
    _isLoading = true;
    notifyListeners();
    _selectedRecipe = Recipe.fromJson(await _apiService.fetchRecipeDetails(id));
    _isLoading = false;
    notifyListeners();
  }
}
