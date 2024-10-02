import '../models/ingredient.dart';

class Recipe {
  String id; // ID della ricetta
  String title;
  String description;
  String preparation;
  String imageUrl;
  int cookingTime; // Presumibilmente in minuti
  int servings;
  String difficulty;
  String cost;
  String cookingMethod;
  List<Ingredient> ingredients; // Lista di ingredienti

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.preparation,
    required this.imageUrl,
    required this.cookingTime,
    required this.servings,
    required this.difficulty,
    required this.cost,
    required this.cookingMethod,
    required this.ingredients,
  });

  // Metodo per convertire un oggetto Recipe in una mappa (es. per invio API)
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Includi l'ID solo se necessario
      'title': title,
      'description': description,
      'preparation': preparation,
      'imageUrl': imageUrl,
      'cookingTime': cookingTime,
      'servings': servings,
      'difficulty': difficulty,
      'cost': cost,
      'cookingMethod': cookingMethod,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
    };
  }

  // Factory method per creare un oggetto Recipe da una mappa (es. da un JSON)
  factory Recipe.fromMap(Map<String, dynamic> data) {
    return Recipe(
      id: data['id'] ??
          '', // Verifica che ci sia un id, altrimenti imposta una stringa vuota
      title: data['title'],
      description: data['description'],
      preparation: data['preparation'],
      imageUrl: data['imageUrl'],
      cookingTime: data['cookingTime'],
      servings: data['servings'],
      difficulty: data['difficulty'],
      cost: data['cost'],
      cookingMethod: data['cookingMethod'],
      ingredients: (data['ingredients'] as List)
          .map((ingredient) => Ingredient.fromMap(ingredient))
          .toList(),
    );
  }
}
