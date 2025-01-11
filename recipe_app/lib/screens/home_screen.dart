import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/screens/login_screen.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedDiet;

  final List<String> _categories = ['breakfast', 'lunch', 'dinner'];
  final List<String> _diets = ['vegetarian', 'vegan', 'gluten-free'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await SharedPreferences.getInstance().then(
                (prefs) => prefs.remove('token'),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search for recipes',
              ),
            ),
          ),
          DropdownButton<String>(
            value: _selectedCategory,
            hint: Text('Select Category'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            items:
                _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
          ),
          DropdownButton<String>(
            value: _selectedDiet,
            hint: Text('Select Diet'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedDiet = newValue;
              });
            },
            items:
                _diets.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<RecipeProvider>().fetchRecipes(
                _searchController.text,
                category: _selectedCategory,
                diet: _selectedDiet,
              );
            },
            child: Text('Search'),
          ),
          Expanded(
            child: Consumer<RecipeProvider>(
              builder: (context, provider, child) {
                if (provider.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (provider.recipes.isEmpty) {
                  return Center(child: Text('No recipes found'));
                }
                return ListView.builder(
                  itemCount: provider.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = provider.recipes[index];
                    return ListTile(
                      title: Text(recipe.title),
                      leading: Image.network(recipe.image),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    RecipeDetailScreen(recipeId: recipe.id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
