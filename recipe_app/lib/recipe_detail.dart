import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  RecipeDetail({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Immagine della ricetta
            Image.asset(
              recipe.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Difficoltà: ${recipe.difficulty}', // Aggiungi difficoltà
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Tempo di cottura: ${recipe.cookingTime} minuti', // Aggiungi tempo di cottura
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Tempo di preparazione: ${recipe.preparationTime} minuti', // Aggiungi tempo di preparazione
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Porzioni: ${recipe.servings}', // Aggiungi porzioni
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Costo: ${recipe.cost}', // Aggiungi costo
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  // Icone per le informazioni
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.star,
                          color: Colors
                              .yellow[700]), // Esempio di icona per difficoltà
                      Icon(Icons.timer,
                          color: Colors
                              .orange), // Esempio di icona per tempo di cottura
                      Icon(Icons.timer,
                          color: Colors
                              .orange), // Esempio di icona per tempo di cottura
                      Icon(Icons.person,
                          color: Colors.blue), // Esempio di icona per porzioni
                      Icon(Icons.euro,
                          color: Colors.blue), // Esempio di icona per porzioni
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ingredienti',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Ingrediente'),
                      )),
                      TableCell(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Quantità'),
                      )),
                    ],
                  ),
                  ...recipe.ingredients
                      .map((ingredient) => TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(ingredient.name),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(ingredient.quantity),
                              )),
                            ],
                          ))
                      .toList(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Preparazione',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(recipe.preparation),
            ),
          ],
        ),
      ),
    );
  }
}
