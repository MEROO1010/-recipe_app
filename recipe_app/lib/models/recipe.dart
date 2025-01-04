class Recipe {
  final int id;
  final String title;
  final String image;
  final String summary;
  final int readyInMinutes;
  final int servings;
  final List<String> ingredients;
  final List<String> instructions;
  final Map<String, dynamic> nutrition;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.summary,
    required this.readyInMinutes,
    required this.servings,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      summary: json['summary'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      ingredients: List<String>.from(
        json['extendedIngredients'].map((x) => x['original']),
      ),
      instructions: List<String>.from(
        json['analyzedInstructions'][0]['steps'].map((x) => x['step']),
      ),
      nutrition: json['nutrition'],
    );
  }
}
