import 'package:pocketbase/pocketbase.dart';
import '../models/recipe.dart';

final pb = PocketBase('http://127.0.0.1:8090');

class PocketBaseService {
  // Fetch all recipes
  Future<List<Recipe>> getRecipes({int page = 1, int perPage = 30}) async {
    // Ottieni la lista paginata delle ricette
    final resultList = await pb.collection('recipes').getList(
          page: page,
          perPage: perPage,
        );

    // Mappa i risultati a oggetti Recipe
    return resultList.items.map<Recipe>((item) {
      return Recipe(
        id: item.id, // Assicurati di avere un campo 'id' nel modello Recipe
        title: item['title'],
        description: item['description'],
        preparation: item['preparation'],
        imageUrl: item['imageUrl'],
        cookingTime: item['cookingTime'],
        difficulty: item['difficulty'],
        cost: item['cost'],
        ingredients: List<String>.from(item['ingredients']),
      );
    }).toList();
  }

  // Aggiungi una nuova ricetta
  Future<void> addRecipe(Recipe recipe) async {
    await pb.collection('recipes').create(data: {
      'title': recipe.title,
      'description': recipe.description,
      'preparation': recipe.preparation,
      'imageUrl': recipe.imageUrl,
      'cookingTime': recipe.cookingTime,
      'difficulty': recipe.difficulty,
      'cost': recipe.cost,
      'ingredients': recipe.ingredients,
    });
  }

  // Modifica una ricetta esistente
  Future<void> updateRecipe(String id, Recipe recipe) async {
    await pb.collection('recipes').update(id, data: {
      'title': recipe.title,
      'description': recipe.description,
      'preparation': recipe.preparation,
      'imageUrl': recipe.imageUrl,
      'cookingTime': recipe.cookingTime,
      'difficulty': recipe.difficulty,
      'cost': recipe.cost,
      'ingredients': recipe.ingredients,
    });
  }

  // Elimina una ricetta
  Future<void> deleteRecipe(String id) async {
    await pb.collection('recipes').delete(id);
  }
}
