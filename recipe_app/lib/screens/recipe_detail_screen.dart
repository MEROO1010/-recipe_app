import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipe_detail_provider.dart';
import 'package:recipe_app/providers/favorites_provider.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final int recipeId;

  RecipeDetailScreen({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
        actions: [
          Consumer<RecipeDetailProvider>(
            builder: (context, provider, child) {
              final recipeDetail = provider.recipeDetail;
              if (recipeDetail == null) {
                return Container();
              }

              final recipe = Recipe(
                id: recipeDetail.id,
                title: recipeDetail.title,
                image: recipeDetail.image,
              );

              final isFavorite = context.watch<FavoritesProvider>().isFavorite(
                recipe,
              );

              return IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  if (isFavorite) {
                    context.read<FavoritesProvider>().removeFavorite(recipe);
                  } else {
                    context.read<FavoritesProvider>().addFavorite(recipe);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: context.read<RecipeDetailProvider>().fetchRecipeDetails(
          recipeId,
        ),
        builder: (context, snapshot) {
          if (context.watch<RecipeDetailProvider>().loading) {
            return Center(child: CircularProgressIndicator());
          }

          final recipeDetail =
              context.watch<RecipeDetailProvider>().recipeDetail;

          if (recipeDetail == null) {
            return Center(child: Text('Failed to load recipe details'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(recipeDetail.image),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    recipeDetail.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Servings: ${recipeDetail.servings}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ready in: ${recipeDetail.readyInMinutes} minutes',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...recipeDetail.ingredients.map((ingredient) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(ingredient['original']),
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Instructions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(recipeDetail.instructions),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
