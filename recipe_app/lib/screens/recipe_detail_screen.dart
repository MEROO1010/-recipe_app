import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeProvider>(context).selectedRecipe;

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Recipe Details')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(recipe.image),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Ready in ${recipe.readyInMinutes} minutes'),
                  SizedBox(height: 8),
                  Text('Servings: ${recipe.servings}'),
                  SizedBox(height: 8),
                  Text(
                    'Ingredients:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var ingredient in recipe.ingredients) Text(ingredient),
                  SizedBox(height: 8),
                  Text(
                    'Instructions:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (var step in recipe.instructions) Text(step),
                  SizedBox(height: 8),
                  Text(
                    'Nutritional Information:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Calories: ${recipe.nutrition['calories']}'),
                  Text('Protein: ${recipe.nutrition['protein']}g'),
                  Text('Carbs: ${recipe.nutrition['carbs']}g'),
                  Text('Fat: ${recipe.nutrition['fat']}g'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Implement save functionality
                    },
                    child: Text('Save Recipe'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
