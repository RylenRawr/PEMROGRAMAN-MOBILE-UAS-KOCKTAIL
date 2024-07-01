import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import 'package:provider/provider.dart';
import '../providers/cocktail_provider.dart';

class CocktailDetailPage extends StatelessWidget {
  final Cocktail cocktail;

  CocktailDetailPage({required this.cocktail});

  @override
  Widget build(BuildContext context) {
    Provider.of<CocktailProvider>(context, listen: false).fetchRecommendations();

    return Scaffold(
      appBar: AppBar(
        title: Text(cocktail.name),
        backgroundColor: Colors.blueAccent,
        actions: [
          Consumer<CocktailProvider>(
            builder: (context, provider, child) {
              final isFavorite = provider.isFavorite(cocktail);
              return IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  if (isFavorite) {
                    provider.removeFromFavorites(cocktail);
                  } else {
                    provider.addToFavorites(cocktail);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(cocktail.thumbnailUrl),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                cocktail.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Text(
              'Kategori: ${cocktail.category}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Gelas: ${cocktail.glass}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                cocktail.instructions,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bahan:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  for (int i = 0; i < cocktail.ingredients.length; i++)
                    Row(
                      children: [
                        Image.network(cocktail.ingredientImages[i], width: 50, height: 50),
                        SizedBox(width: 8),
                        Text(cocktail.ingredients[i], style: TextStyle(color: Colors.white)),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Consumer<CocktailProvider>(
                builder: (context, provider, child) {
                  if (provider.recommendations.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rekomendasi Minuman:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.recommendations.length,
                          itemBuilder: (context, index) {
                            final recommendation = provider.recommendations[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CocktailDetailPage(cocktail: recommendation)),
                              ),
                              child: Card(
                                color: Color(0xFF1F1F1F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                                      child: Image.network(
                                        recommendation.thumbnailUrl,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        recommendation.name,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
