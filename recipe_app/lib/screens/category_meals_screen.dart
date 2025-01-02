import 'package:flutter/material.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/recipe_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipe_app/screens/meal_detail_screen.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: FutureBuilder<List<Recipe>>(
        future: RecipeApi.fetchRecipes(category.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recipes found'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MealDetailScreen.routeName,
                      arguments: recipe.id,
                    );
                  },
                  child: GridTile(
                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      placeholder:
                          (context, url) =>
                              Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(recipe.title, textAlign: TextAlign.center),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
