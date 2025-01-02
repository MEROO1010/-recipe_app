// lib/models/recipe.dart
class Recipe {
  final int id;
  final String title;
  final String image;
  final String sourceUrl;
  final String summary;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.sourceUrl,
    required this.summary,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      sourceUrl: json['sourceUrl'],
      summary: json['summary'],
    );
  }
}
