class Cocktail {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String category;
  final String glass;
  final String instructions;
  final List<String> ingredients;
  final List<String> ingredientImages;

  Cocktail({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    required this.category,
    required this.glass,
    required this.instructions,
    required this.ingredients,
    required this.ingredientImages,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> ingredientImages = [];
    for (int i = 1; i <= 15; i++) {
      if (json['strIngredient$i'] != null) {
        ingredients.add(json['strIngredient$i']);
        ingredientImages.add('https://www.thecocktaildb.com/images/ingredients/${json['strIngredient$i']}-Small.png');
      }
    }

    return Cocktail(
      id: json['idDrink'],
      name: json['strDrink'],
      thumbnailUrl: json['strDrinkThumb'] ?? '',
      category: json['strCategory'] ?? '',
      glass: json['strGlass'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
      ingredientImages: ingredientImages,
    );
  }
}
