import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cocktail_provider.dart';
import 'cocktail_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites banyu andaa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<CocktailProvider>(
        builder: (context, provider, child) {
          if (provider.favorites.isEmpty) {
            return Center(child: Text('Tidak ada Minuman Favorit', style: TextStyle(color: Colors.white)));
          }
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              final cocktail = provider.favorites[index];
              return Card(
                color: Color(0xFF1F1F1F),
                margin: EdgeInsets.all(10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    cocktail.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      cocktail.thumbnailUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CocktailDetailPage(cocktail: cocktail)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
