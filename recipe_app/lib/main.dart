import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/screens/home_screen.dart';
import 'package:recipe_app/ui/styles/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RecipeProvider())],
      child: MaterialApp(
        title: 'Recipe App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: HomeScreen(),
      ),
    );
  }
}
