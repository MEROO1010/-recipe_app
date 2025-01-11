class RecipeDetail {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final String instructions;
  final List<dynamic> ingredients;

  RecipeDetail({
    required this.id,
    required this.title,
    required this.image,
    required this.servings,
    required this.readyInMinutes,
    required this.instructions,
    required this.ingredients,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      servings: json['servings'],
      readyInMinutes: json['readyInMinutes'],
      instructions: json['instructions'],
      ingredients: json['extendedIngredients'],
    );
  }
}
