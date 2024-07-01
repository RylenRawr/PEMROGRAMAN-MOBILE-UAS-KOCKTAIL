import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cocktail.dart';

class APIService {
  static const String _baseUrl = 'www.thecocktaildb.com';
  static const String _apiKey = '1';

  Future<List<Cocktail>> fetchCocktailsByFirstLetter(String letter) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/search.php', {'f': letter});
    return _fetchCocktailsFromUri(uri);
  }

  Future<List<Cocktail>> searchCocktailsByName(String name) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/search.php', {'s': name});
    return _fetchCocktailsFromUri(uri);
  }

  Future<List<Cocktail>> filterCocktailsByIngredient(String ingredient) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/filter.php', {'i': ingredient});
    return _fetchCocktailsFromUri(uri);
  }

  Future<List<Cocktail>> filterCocktailsByAlcoholic(String alcoholic) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/filter.php', {'a': alcoholic});
    return _fetchCocktailsFromUri(uri);
  }

  Future<List<Cocktail>> filterCocktailsByCategory(String category) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/filter.php', {'c': category});
    return _fetchCocktailsFromUri(uri);
  }

  Future<List<Cocktail>> filterCocktailsByGlass(String glass) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/filter.php', {'g': glass});
    return _fetchCocktailsFromUri(uri);
  }

  Future<Cocktail> lookupCocktailById(String id) async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/lookup.php', {'i': id});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return Cocktail.fromJson(body['drinks'][0]);
    } else {
      throw Exception('Failed to load cocktail details');
    }
  }

  Future<Cocktail> getRandomCocktail() async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/random.php');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return Cocktail.fromJson(body['drinks'][0]);
    } else {
      throw Exception('Failed to load random cocktail');
    }
  }

  Future<List<Cocktail>> getRecommendations() async {
    List<Cocktail> recommendations = [];
    for (int i = 0; i < 5; i++) {
      final uri = Uri.https(_baseUrl, '/api/json/v1/$_apiKey/random.php');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        recommendations.add(Cocktail.fromJson(body['drinks'][0]));
      }
    }
    return recommendations;
  }

  Future<List<Cocktail>> _fetchCocktailsFromUri(Uri uri) async {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return (body['drinks'] as List)
          .map((dynamic item) => Cocktail.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load cocktails');
    }
  }
}
