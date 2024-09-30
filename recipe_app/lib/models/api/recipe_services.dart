import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/recipe_web.dart';

class RecipeService {
  final String apiKey = '2fa3265ab7164067847541ba4f916697';

  Future<List<Recipe>> searchRecipes(String query) async {
    final url =
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data); // Stampa la risposta per il debug
      List<dynamic> results = data['results'];
      return results.map((recipeData) => Recipe.fromJson(recipeData)).toList();
    } else {
      throw Exception('Errore nella ricerca delle ricette');
    }
  }
}
