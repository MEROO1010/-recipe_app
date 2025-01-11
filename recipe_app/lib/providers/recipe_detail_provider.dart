import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_detail.dart';
import 'package:recipe_app/services/api_service.dart';

class RecipeDetailProvider with ChangeNotifier {
  RecipeDetail? _recipeDetail;
  bool _loading = false;

  RecipeDetail? get recipeDetail => _recipeDetail;
  bool get loading => _loading;

  Future<void> fetchRecipeDetails(int id) async {
    _loading = true;
    notifyListeners();

    try {
      _recipeDetail = RecipeDetail.fromJson(
        await ApiService().fetchRecipeDetails(id),
      );
    } catch (error) {
      _recipeDetail = null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
