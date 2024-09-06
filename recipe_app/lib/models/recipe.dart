class Recipe {
  final String title;
  final String description;
  final String preparation;
  final String imageUrl; // Percorso dell'immagine
  final String difficulty; // Difficoltà
  final String cookingTime; // Tempo di cottura
  final int servings; // Porzioni
  final List<Ingredient> ingredients; // Lista degli ingredienti
  final String preparationTime; // Tempo di preparazione
  final String cost; // Costo

  Recipe({
    required this.title,
    required this.description,
    required this.preparation,
    required this.imageUrl,
    required this.difficulty,
    required this.cookingTime,
    required this.servings,
    required this.ingredients,
    required this.preparationTime,
    required this.cost,
  });
}

class Ingredient {
  final String name;
  final String quantity;

  Ingredient({required this.name, required this.quantity});
}
