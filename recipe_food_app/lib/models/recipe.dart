class Recipe {
  String id; // Aggiunto id
  String title;
  String description;
  String preparation;
  String imageUrl;
  int cookingTime; // Presumibilmente in minuti
  String difficulty;
  String cost;
  List<String> ingredients;

  Recipe({
    required this.id, // Inizializza l'id
    required this.title,
    required this.description,
    required this.preparation,
    required this.imageUrl,
    required this.cookingTime,
    required this.difficulty,
    required this.cost,
    required this.ingredients,
  });
}
