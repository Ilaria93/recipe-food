import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/recipe_list.dart';
import 'screens/add_edit_recipe.dart';
import 'screens/recipe_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // Utilizza le opzioni generate
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App di Ricette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/recipeList': (context) => RecipeList(),
        '/addRecipe': (context) => const AddEditRecipePage(),
      },
    );
  }
}
