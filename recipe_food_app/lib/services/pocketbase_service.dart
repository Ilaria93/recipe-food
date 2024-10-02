import 'package:pocketbase/pocketbase.dart';
import '../models/recipe.dart';
import '../models/ingredient.dart';

final pb = PocketBase('http://127.0.0.1:8090');

class PocketBaseService {
  final PocketBase pb =
      PocketBase('http://127.0.0.1:8090'); // Crea l'istanza di PocketBase

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
        id: item.data['id'] as String? ??
            item.id, // Assicurati di avere un campo 'id' nel modello Recipe
        title: item.data['title'],
        description: item.data['description'],
        preparation: item.data['preparation'],
        imageUrl: item.data['imageUrl'],
        cookingTime: item.data['cookingTime'],
        difficulty: item.data['difficulty'],
        servings: item.data['servings'],
        cookingMethod: item.data['cookingMethod'],
        cost: item.data['cost'],
        // Converti la lista di ingredienti in oggetti Ingredient
        ingredients: (item.data['ingredients'] as List)
            .map<Ingredient>((ingredient) =>
                Ingredient.fromMap(ingredient as Map<String, dynamic>))
            .toList(),
      );
    }).toList();
  }

  // Aggiungi una nuova ricetta
  Future<void> addRecipe(Recipe recipe) async {
    await pb.collection('recipes').create(body: {
      'title': recipe.title,
      'description': recipe.description,
      'preparation': recipe.preparation,
      'imageUrl': recipe.imageUrl,
      'cookingTime': recipe.cookingTime,
      'difficulty': recipe.difficulty,
      'cost': recipe.cost,
      'servings': recipe.servings,
      'cookingMethod': recipe.cookingMethod,
      'ingredients': recipe.ingredients,
    });
  }

  // Modifica una ricetta esistente
  Future<void> updateRecipe(Recipe recipe) async {
    await pb.collection('recipes').update(recipe.id, body: {
      'title': recipe.title,
      'description': recipe.description,
      'preparation': recipe.preparation,
      'imageUrl': recipe.imageUrl,
      'cookingTime': recipe.cookingTime,
      'difficulty': recipe.difficulty,
      'cost': recipe.cost,
      'servings': recipe.servings,
      'cookingMethod': recipe.cookingMethod,
      'ingredients': recipe.ingredients,
    });
  }

  // Elimina una ricetta
  Future<void> deleteRecipe(String id) async {
    await pb.collection('recipes').delete(id);
  }

  // Funzione per effettuare il login
  // Login admin
  Future<void> login(String email, String password) async {
    try {
      final authData = await pb.admins.authWithPassword(email, password);
      print('Login admin successo: ${authData.token}');
    } catch (e) {
      print('Errore durante il login admin: $e');
    }
  }

  // Funzione per effettuare il logout
  Future<void> logout() async {
    pb.authStore.clear(); // Pulisci il token di autenticazione
  }
}
