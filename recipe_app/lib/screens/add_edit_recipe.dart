import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../../models/recipe.dart';

class AddEditRecipePage extends StatefulWidget {
  final Recipe? recipe;

  const AddEditRecipePage({super.key, this.recipe});

  @override
  _AddEditRecipePageState createState() => _AddEditRecipePageState();
}

class _AddEditRecipePageState extends State<AddEditRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _preparationController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _difficultyController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController();
  final TextEditingController _cookingMethodController =
      TextEditingController();
  final TextEditingController _costController = TextEditingController();

  List<Ingredient> _ingredients = [];

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _titleController.text = widget.recipe!.title;
      _descriptionController.text = widget.recipe!.description;
      _preparationController.text = widget.recipe!.preparation;
      _imageUrlController.text = widget.recipe!.imageUrl;
      _difficultyController.text = widget.recipe!.difficulty;
      _cookingTimeController.text = widget.recipe!.cookingTime.toString();
      _servingsController.text = widget.recipe!.servings.toString();
      _cookingMethodController.text = widget.recipe!.cookingMethod;
      _costController.text = widget.recipe!.cost.toString();
      _ingredients = widget.recipe!.ingredients;
    }
  }

  void _addIngredient() {
    showDialog(
      context: context,
      builder: (context) {
        final ingredientNameController = TextEditingController();
        final ingredientQuantityController = TextEditingController();

        return AlertDialog(
          title: const Text('Aggiungi Ingrediente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ingredientNameController,
                decoration:
                    const InputDecoration(labelText: 'Nome Ingrediente'),
              ),
              TextField(
                controller: ingredientQuantityController,
                decoration: const InputDecoration(labelText: 'Quantità'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (ingredientNameController.text.isNotEmpty &&
                    ingredientQuantityController.text.isNotEmpty) {
                  setState(() {
                    _ingredients.add(Ingredient(
                      name: ingredientNameController.text,
                      quantity: ingredientQuantityController.text,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Aggiungi'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annulla'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.recipe == null ? 'Aggiungi Ricetta' : 'Modifica Ricetta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titolo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci un titolo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrizione'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci una descrizione';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _preparationController,
                decoration: const InputDecoration(labelText: 'Preparazione'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci le istruzioni di preparazione';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL Immagine'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci un URL per l\'immagine';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _difficultyController,
                decoration: const InputDecoration(labelText: 'Difficoltà'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci la difficoltà';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cookingTimeController,
                decoration:
                    const InputDecoration(labelText: 'Tempo di cottura (min)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il tempo di cottura';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _servingsController,
                decoration: const InputDecoration(labelText: 'Porzioni'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il numero di porzioni';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cookingMethodController,
                decoration:
                    const InputDecoration(labelText: 'Metodo di Cottura'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il metodo di cottura';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(labelText: 'Costo (€)'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il costo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addIngredient,
                child: const Text('Aggiungi Ingrediente'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: _ingredients.map((ingredient) {
                    return ListTile(
                      title: Text(ingredient.name),
                      subtitle: Text(ingredient.quantity),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newRecipe = Recipe(
                      id: '', // L'ID verrà generato automaticamente da Firestore
                      title: _titleController.text,
                      description: _descriptionController.text,
                      preparation: _preparationController.text,
                      imageUrl: _imageUrlController.text,
                      difficulty: _difficultyController.text,
                      cookingTime: int.parse(_cookingTimeController.text),
                      servings: int.parse(_servingsController.text),
                      cookingMethod: _cookingMethodController.text,
                      cost: double.parse(_costController.text),
                      ingredients: _ingredients,
                    );

                    if (widget.recipe == null) {
                      // Aggiungi nuova ricetta
                      await DatabaseHelper().addRecipe(newRecipe);
                    } else {
                      // Modifica ricetta esistente
                      await DatabaseHelper().updateRecipe(newRecipe);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.recipe == null ? 'Aggiungi' : 'Modifica'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
