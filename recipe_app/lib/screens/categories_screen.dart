import 'package:flutter/material.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/screens/category_meals_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Breakfast', imageUrl: 'https://example.com/breakfast.jpg'),
    Category(name: 'Lunch', imageUrl: 'https://example.com/lunch.jpg'),
    Category(name: 'Dinner', imageUrl: 'https://example.com/dinner.jpg'),
    Category(name: 'Dessert', imageUrl: 'https://example.com/dessert.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                CategoryMealsScreen.routeName,
                arguments: category,
              );
            },
            child: GridTile(
              child: Image.network(category.imageUrl, fit: BoxFit.cover),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(category.name, textAlign: TextAlign.center),
              ),
            ),
          );
        },
      ),
    );
  }
}
