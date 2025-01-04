import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Explorer'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: RecipeSearch());
            },
          ),
        ],
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: provider.recipes.length,
            itemBuilder: (context, index) {
              final recipe = provider.recipes[index];
              return ListTile(
                leading: Image.network(recipe.image),
                title: Text(recipe.title),
                subtitle: Text(recipe.summary),
                onTap: () {
                  provider.fetchRecipeDetails(recipe.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class RecipeSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, provider, child) {
        provider.searchRecipes(query);
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: provider.recipes.length,
          itemBuilder: (context, index) {
            final recipe = provider.recipes[index];
            return ListTile(
              leading: Image.network(recipe.image),
              title: Text(recipe.title),
              subtitle: Text(recipe.summary),
              onTap: () {
                provider.fetchRecipeDetails(recipe.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeDetailScreen()),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
