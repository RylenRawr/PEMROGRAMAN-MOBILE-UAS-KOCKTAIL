import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/cocktail.dart';

class CocktailProvider with ChangeNotifier {
  List<Cocktail> _cocktails = [];
  List<Cocktail> _recommendations = [];
  List<Cocktail> _favorites = [];
  List<Cocktail> get cocktails => _cocktails;
  List<Cocktail> get recommendations => _recommendations;
  List<Cocktail> get favorites => _favorites;

  CocktailProvider() {
    fetchCocktailsByFirstLetter('a');
  }

  void fetchCocktailsByFirstLetter(String letter) async {
    _cocktails = await APIService().fetchCocktailsByFirstLetter(letter);
    notifyListeners();
  }

  void searchCocktailsByName(String name) async {
    _cocktails = await APIService().searchCocktailsByName(name);
    notifyListeners();
  }

  void filterCocktailsByIngredient(String ingredient) async {
    _cocktails = await APIService().filterCocktailsByIngredient(ingredient);
    notifyListeners();
  }

  void filterCocktailsByAlcoholic(String alcoholic) async {
    _cocktails = await APIService().filterCocktailsByAlcoholic(alcoholic);
    notifyListeners();
  }

  void filterCocktailsByCategory(String category) async {
    _cocktails = await APIService().filterCocktailsByCategory(category);
    notifyListeners();
  }

  void filterCocktailsByGlass(String glass) async {
    _cocktails = await APIService().filterCocktailsByGlass(glass);
    notifyListeners();
  }

  Future<Cocktail> getRandomCocktail() async {
    Cocktail randomCocktail = await APIService().getRandomCocktail();
    notifyListeners();
    return randomCocktail;
  }

  void fetchCocktailDetails(String id) async {
    Cocktail cocktail = await APIService().lookupCocktailById(id);
    _cocktails = [cocktail];
    notifyListeners();
  }

  void filterCocktailsByNonAlcoholic() async {
    _cocktails = await APIService().filterCocktailsByAlcoholic('Non_Alcoholic');
    notifyListeners();
  }

  void fetchRecommendations() async {
    _recommendations = await APIService().getRecommendations();
    notifyListeners();
  }

  void addToFavorites(Cocktail cocktail) {
    if (!_favorites.contains(cocktail)) {
      _favorites.add(cocktail);
      notifyListeners();
    }
  }

  void removeFromFavorites(Cocktail cocktail) {
    _favorites.remove(cocktail);
    notifyListeners();
  }

  bool isFavorite(Cocktail cocktail) {
    return _favorites.contains(cocktail);
  }
}
