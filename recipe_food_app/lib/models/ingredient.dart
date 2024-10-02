class Ingredient {
  final String name;
  final String quantity;

  Ingredient({
    required this.name,
    required this.quantity,
  });

  // Factory method per creare un oggetto Ingredient da una mappa
  factory Ingredient.fromMap(Map<String, dynamic> data) {
    return Ingredient(
      name: data['name'],
      quantity: data['quantity'], // Cast to double
    );
  }

  // Metodo per convertire l'oggetto Ingredient in una mappa
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}
