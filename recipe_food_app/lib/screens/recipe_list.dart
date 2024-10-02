import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'recipe_details.dart';
import 'add_edit_recipe.dart';
import '../services/pocketbase_service.dart';
import 'home_page.dart'; // Importa la homepage

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  final PocketBaseService _pocketBaseService = PocketBaseService();
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    var response = await _pocketBaseService.getRecipes();
    setState(() {
      recipes = response; // Usa direttamente la risposta
    });
  }

  // Funzione per gestire il logout
  Future<void> _logout() async {
    await _pocketBaseService
        .logout(); // Assicurati di avere un metodo logout nel servizio
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Torna alla home
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista di Ricette'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Icona di logout
            onPressed: _logout, // Gestisci il logout
          ),
        ],
      ),
      body: recipes.isEmpty // Aggiunto un controllo per la lista vuota
          ? Center(
              child: CircularProgressIndicator(),
            ) // Mostra un caricamento se la lista è vuota
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  recipe: recipes[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetail(recipe: recipes[index]),
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
          ).then((_) => _loadRecipes()); // Ricarica le ricette dopo l'aggiunta
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// class RecipeList extends StatelessWidget {
//   final List<Recipe> recipes = [
//     Recipe(
//       title: 'Spaghetti alla Carbonara',
//       description: 'Pasta, uova, pancetta...',
//       preparation:
//           'Per preparare gli spaghetti alla carbonara cominciate mettendo sul fuoco una pentola con l’acqua salata per cuocere la pasta. Nel frattempo eliminate la cotenna dal guanciale e tagliatelo prima a fette e poi a striscioline spesse circa 1cm. La cotenna avanzata potrà essere riutilizzata per insaporire altre preparazioni. Versate i pezzetti di guanciale in una padella antiaderente, e rosolate per circa 10 minuti a fiamma medio alta, fate attenzione a non bruciarlo altrimenti rilascerà un aroma troppo forte. Nel frattempo tuffate gli spaghetti nell’acqua bollente e cuoceteli al dente. Intanto versate i tuorli in una ciotola.Aggiungete il Pecorino  e insaporite con il pepe nero. Amalgamate il tutto con una frusta a mano , sino ad ottenere una crema liscia. Intanto il guanciale sarà giunto a cottura; spegnete il fuoco e utilizzando un mestolo prelevatelo dalla padella, lasciando il fondo di cottura allinterno della padella stessa. Trasferite il guanciale in una ciotolina e tenetelo da parte. Versate una mestolata d’acqua della pasta in padella, insieme al grasso del guanciale.Scolate la pasta al dente direttamente nel tegame con il fondo di cottura. Saltatela brevemente per insaporirla. Togliete dal fuoco e versate il composto di uova e Pecorino nel tegame. Mescolate velocemente per amalgamare. Per renderla ben cremosa, al bisogno, potete aggiungere poca acqua di cottura della pasta. Aggiungete il guanciale, mescolate un ultima volta e servite subito gli spaghetti alla carbonara aggiungendo ancora del pecorino in superficie e un pizzico di pepe nero.',
//       imageUrl: 'assets/images/carbonara.jpg',
//       difficulty: 'Facile', // Difficoltà
//       cookingTime: 10, // Tempo di cottura
//       servings: 4, // Porzioni
//       ingredients: [
//         Ingredient(name: 'Spaghetti', quantity: '320gr'),
//         Ingredient(name: 'Tuorli', quantity: '6 uova medie'),
//         Ingredient(name: 'Guanciale', quantity: '150 gr'),
//         Ingredient(name: 'Pecorino Romano DOP', quantity: '50 gr'),
//         Ingredient(name: 'Pepe nero', quantity: 'q.b.'),
//       ], // Lista degli ingredienti
//       cookingMethod: '15',
//       cost: 0.00,
//     ),
//     Recipe(
//       title: 'Tiramisù',
//       description: 'Savoiardi, mascarpone, caffè...',
//       preparation: 'Preparare il mascarpone...',
//       imageUrl: 'assets/images/tiramisù.jpg',
//       difficulty: 'Facile', // Difficoltà
//       cookingTime: 10, // Tempo di cottura
//       servings: 4, // Porzioni
//       ingredients: [], // Lista degli ingredienti
//       cookingMethod: '15',
//       cost: 0.00,
//     ),
//     Recipe(
//       title: 'Lasagna',
//       description: 'Pasta, ragù, besciamella...',
//       preparation: 'Preparare il ragù...',
//       imageUrl: 'assets/images/lasagne.jpg',
//       difficulty: 'Facile', // Difficoltà
//       cookingTime: 10, // Tempo di cottura
//       servings: 4, // Porzioni
//       ingredients: [], // Lista degli ingredienti
//       cookingMethod: '15',
//       cost: 0.00,
//     ),
//   ];
// }
