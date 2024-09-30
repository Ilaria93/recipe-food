import 'package:flutter/material.dart';
import '../models/api/recipe_services.dart'; // Importa il servizio API
import '../models/recipe_web.dart'; // Importa il modello Recipe

class RecipeSearchPage extends StatefulWidget {
  @override
  _RecipeSearchPageState createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  final _searchController = TextEditingController();
  List<Recipe> _recipes = [];
  bool _isLoading = false;

  void _searchRecipes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final service = RecipeService();
      final recipes = await service.searchRecipes(_searchController.text);
      setState(() {
        _recipes = recipes;
      });
    } catch (e) {
      print('Errore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante la ricerca delle ricette: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cerca Ricette'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Inserisci parola chiave',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchRecipes,
                ),
              ),
              onSubmitted: (_) => _searchRecipes(),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _recipes[index];
                        return ListTile(
                          leading: Image.network(recipe.imageUrl,
                              width: 50, height: 50),
                          title: Text(recipe.title),
                          subtitle: Text(
                            'Tempo di preparazione: ${recipe.cookingTime != null ? recipe.cookingTime.toString() : 'N/A'} minuti',
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
