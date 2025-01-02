import 'package:flutter/material.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/screens/recipe_list_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Breakfast', imageUrl: ''),
    Category(name: 'Lunch', imageUrl: ''),
    Category(name: 'Dinner', imageUrl: ''),
    Category(name: 'Dessert', imageUrl: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeListScreen(category: category),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
