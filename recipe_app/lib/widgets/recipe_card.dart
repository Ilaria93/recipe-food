import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({super.key, required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        title: Text(recipe.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              recipe.imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              recipe.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
