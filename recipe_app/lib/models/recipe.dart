class Ingredient {
  final String name;
  final String quantity;

  Ingredient({required this.name, required this.quantity});
}

class Recipe {
  final int? id;
  final String title;
  final String description;
  final String preparation;
  final List<Ingredient> ingredients;
  final String imageUrl;
  final String difficulty;
  final int cookingTime;
  final int servings;
  final String cookingMethod;
  final double cost;

  Recipe({
    this.id,
    required this.title,
    required this.description,
    required this.preparation,
    required this.imageUrl,
    required this.difficulty,
    required this.cookingTime,
    required this.servings,
    required this.ingredients,
    required this.cookingMethod,
    required this.cost,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'preparation': preparation,
      'imageUrl': imageUrl,
      'difficulty': difficulty,
      'cookingTime': cookingTime,
      'ingredients': ingredients,
      'servings': servings,
      'cookingMethod': cookingMethod,
      'cost': cost,
    };
  }

  // Aggiungi un costruttore da mappa se necessario
  Recipe.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        preparation = map['preparation'],
        imageUrl = map['imageUrl'],
        difficulty = map['difficulty'],
        cookingTime = map['cookingTime'],
        servings = map['servings'],
        ingredients = map['ingredients'],
        cookingMethod = map['cookingMethod'],
        cost = map['cost'];
}
