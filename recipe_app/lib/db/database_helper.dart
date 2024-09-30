import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/recipe.dart'; // Assicurati di avere il tuo modello Recipe qui

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recipes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            preparation TEXT,
            imageUrl TEXT,
            difficulty TEXT,
            cookingTime INTEGER,
            servings INTEGER,
            cookingMethod TEXT,
            cost REAL
          )
        ''');
      },
    );
  }

  // Funzione per inserire una nuova ricetta
  Future<void> insertRecipe(Recipe recipe) async {
    final db = await database;
    await db.insert(
      'recipes',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Funzione per ottenere tutte le ricette
  Future<List<Recipe>> getRecipes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recipes');

    return List.generate(maps.length, (i) {
      return Recipe(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        preparation: maps[i]['preparation'],
        imageUrl: maps[i]['imageUrl'],
        difficulty: maps[i]['difficulty'],
        cookingTime: maps[i]['cookingTime'],
        servings: maps[i]['servings'],
        ingredients: [], // Add empty list for ingredients
        cookingMethod: maps[i]['cookingMethod'],
        cost: maps[i]['cost'],
      );
    });
  }

  // Funzione per aggiornare una ricetta
  Future<void> updateRecipe(Recipe recipe) async {
    final db = await database;
    await db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  // Funzione per eliminare una ricetta
  Future<void> deleteRecipe(int id) async {
    final db = await database;
    await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
