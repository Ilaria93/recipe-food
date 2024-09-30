import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class DatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Aggiungere una nuova ricetta
  Future<void> addRecipe(Recipe recipe) async {
    await _firestore.collection('recipes').add(recipe.toMap());
  }

  // Ottenere tutte le ricette
  Future<List<Recipe>> getRecipes() async {
    final snapshot = await _firestore.collection('recipes').get();
    return snapshot.docs
        .map((doc) => Recipe.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Aggiornare una ricetta
  Future<void> updateRecipe(Recipe recipe) async {
    await _firestore
        .collection('recipes')
        .doc(recipe.id)
        .update(recipe.toMap());
  }

  // Eliminare una ricetta
  Future<void> deleteRecipe(String id) async {
    await _firestore.collection('recipes').doc(id).delete();
  }
}
