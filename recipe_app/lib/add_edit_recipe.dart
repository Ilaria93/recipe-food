import 'package:flutter/material.dart';
import '../models/recipe.dart';

class AddEditRecipePage extends StatefulWidget {
  final Recipe? recipe;

  AddEditRecipePage({this.recipe});

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
  final TextEditingController _preparationTimeController =
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
      _preparationTimeController.text = widget.recipe!.preparationTime;
      _costController.text = widget.recipe!.cost.toString();
      _ingredients = widget.recipe!.ingredients;
    }
  }

  void _addIngredient() {
    showDialog(
      context: context,
      builder: (context) {
        final _ingredientNameController = TextEditingController();
        final _ingredientQuantityController = TextEditingController();

        return AlertDialog(
          title: Text('Aggiungi Ingrediente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _ingredientNameController,
                decoration: InputDecoration(labelText: 'Nome Ingrediente'),
              ),
              TextField(
                controller: _ingredientQuantityController,
                decoration: InputDecoration(labelText: 'Quantità'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_ingredientNameController.text.isNotEmpty &&
                    _ingredientQuantityController.text.isNotEmpty) {
                  setState(() {
                    _ingredients.add(Ingredient(
                      name: _ingredientNameController.text,
                      quantity: _ingredientQuantityController.text,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Aggiungi'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annulla'),
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
                decoration: InputDecoration(labelText: 'Titolo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci un titolo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrizione'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci una descrizione';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _preparationController,
                decoration: InputDecoration(labelText: 'Preparazione'),
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
                decoration: InputDecoration(labelText: 'URL Immagine'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci un URL per l\'immagine';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _difficultyController,
                decoration: InputDecoration(labelText: 'Difficoltà'),
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
                    InputDecoration(labelText: 'Tempo di cottura (min)'),
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
                decoration: InputDecoration(labelText: 'Porzioni'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il numero di porzioni';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _preparationTimeController,
                decoration: InputDecoration(labelText: 'Metodo di Cottura'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il metodo di cottura';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _costController,
                decoration: InputDecoration(labelText: 'Costo (€)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il costo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addIngredient,
                child: Text('Aggiungi Ingrediente'),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newRecipe = Recipe(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      preparation: _preparationController.text,
                      imageUrl: _imageUrlController.text,
                      difficulty: _difficultyController.text,
                      cookingTime: _cookingTimeController.text,
                      servings: int.parse(_servingsController.text),
                      preparationTime: _preparationTimeController.text,
                      cost: _costController.text,
                      ingredients: _ingredients,
                    );

                    if (widget.recipe == null) {
                      // Aggiungi nuova ricetta
                      // Qui dovresti salvare la ricetta nel database
                    } else {
                      // Modifica ricetta esistente
                      // Qui dovresti aggiornare la ricetta nel database
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
