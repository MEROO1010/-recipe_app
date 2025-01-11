import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/favorites_service.dart';
import 'package:recipe_app/services/database_service.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Recipe> _favorites = [];

  List<Recipe> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final favorites = await DatabaseService().getRecipes();
    _favorites.clear();
    _favorites.addAll(favorites);
    notifyListeners();
  }

  Future<void> addFavorite(Recipe recipe) async {
    final success = await FavoritesService().addFavorite(
      recipe.id,
      recipe.title,
      recipe.image,
    );
    if (success) {
      _favorites.add(recipe);
      await DatabaseService().insertRecipe(recipe);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(Recipe recipe) async {
    final success = await FavoritesService().removeFavorite(recipe.id);
    if (success) {
      _favorites.remove(recipe);
      await DatabaseService().deleteRecipe(recipe.id);
      notifyListeners();
    }
  }

  bool isFavorite(Recipe recipe) {
    return _favorites.any((fav) => fav.id == recipe.id);
  }
}
