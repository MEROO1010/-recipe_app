class Recipe {
  final String title;
  final String image;
  final String sourceUrl;
  final String summary;

  Recipe({
    required this.title,
    required this.image,
    required this.sourceUrl,
    required this.summary,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      image: json['image'],
      sourceUrl: json['sourceUrl'],
      summary: json['summary'],
    );
  }
}
