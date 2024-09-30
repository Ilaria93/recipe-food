class Recipe {
  final String title;
  final String imageUrl;
  final int? cookingTime; // Rendi cookingTime nullable

  Recipe({
    required this.title,
    required this.imageUrl,
    this.cookingTime, // Non obbligatorio
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      imageUrl: json['image'] ?? '', // URL dell'immagine
      cookingTime: json['readyInMinutes'], // Può essere null
    );
  }
}
