import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../recipe_detail.dart';
import '../add_edit_recipe.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes = [
    Recipe(
      title: 'Spaghetti alla Carbonara',
      description: 'Pasta, uova, pancetta...',
      preparation: 'Cuocere la pasta...',
      imageUrl: 'assets/images/carbonara.jpg',
      difficulty: 'Facile', // Difficoltà
      cookingTime: '10', // Tempo di cottura
      servings: 4, // Porzioni
      ingredients: [], // Lista degli ingredienti
      preparationTime: '15',
      cost: '€',
    ),
    Recipe(
      title: 'Tiramisù',
      description: 'Savoiardi, mascarpone, caffè...',
      preparation: 'Preparare il mascarpone...',
      imageUrl: 'assets/images/tiramisù.jpg',
      difficulty: 'Facile', // Difficoltà
      cookingTime: '10 minuti', // Tempo di cottura
      servings: 4, // Porzioni
      ingredients: [], // Lista degli ingredienti
      preparationTime: '15 min',
      cost: '€',
    ),
    Recipe(
      title: 'Lasagna',
      description: 'Pasta, ragù, besciamella...',
      preparation: 'Preparare il ragù...',
      imageUrl: 'assets/images/lasagne.jpg',
      difficulty: 'Facile', // Difficoltà
      cookingTime: '10 minuti', // Tempo di cottura
      servings: 4, // Porzioni
      ingredients: [], // Lista degli ingredienti
      preparationTime: '15 min',
      cost: '€',
    ),
  ];

  RecipeList({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista di Ricette'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: recipes[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetail(recipe: recipes[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditRecipePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
