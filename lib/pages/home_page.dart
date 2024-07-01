import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cocktail_provider.dart';
import 'cocktail_detail_page.dart';
import 'favorites_page.dart';
import '../models/cocktail.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/1.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              AppBar(
                title: Text('Banyu Segar...'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritesPage()),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Color(0xFF1F1F1F),
                        title: Text('Cari Minuman', style: TextStyle(color: Colors.white)),
                        content: TextField(
                          controller: searchController,
                          decoration: InputDecoration(hintText: 'Masukan nama Minuman atau Bahan'),
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Provider.of<CocktailProvider>(context, listen: false)
                                  .searchCocktailsByName(searchController.text);
                              Navigator.of(context).pop();
                            },
                            child: Text('Search', style: TextStyle(color: Colors.blueAccent)),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<CocktailProvider>(context, listen: false)
                                  .filterCocktailsByIngredient(searchController.text);
                              Navigator.of(context).pop();
                            },
                            child: Text('Berdasarkan Bahan', style: TextStyle(color: Colors.blueAccent)),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<CocktailProvider>(context, listen: false)
                                  .filterCocktailsByCategory('Cocktail');
                              Navigator.of(context).pop();
                            },
                            child: Text('Berdasarkan Kategori', style: TextStyle(color: Colors.blueAccent)),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<CocktailProvider>(context, listen: false)
                                  .filterCocktailsByAlcoholic('Alcohol');
                              Navigator.of(context).pop();
                            },
                            child: Text('Berdasarkan Minuman Alcohol', style: TextStyle(color: Colors.blueAccent)),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<CocktailProvider>(context, listen: false)
                                  .filterCocktailsByGlass('Cocktail_glass');
                              Navigator.of(context).pop();
                            },
                            child: Text('Berdasarkan Gelas', style: TextStyle(color: Colors.blueAccent)),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<CocktailProvider>(context, listen: false)
                                  .filterCocktailsByNonAlcoholic();
                              Navigator.of(context).pop();
                            },
                            child: Text('Berdasarkan Minuman Non-Alcohol', style: TextStyle(color: Colors.blueAccent)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Consumer<CocktailProvider>(
                  builder: (context, provider, child) {
                    if (provider.cocktails.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Menampilkan dua kolom
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75, // Rasio aspek yang sesuai
                      ),
                      itemCount: provider.cocktails.length,
                      itemBuilder: (context, index) {
                        final cocktail = provider.cocktails[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CocktailDetailPage(cocktail: cocktail)),
                          ),
                          child: Card(
                            color: Color(0xFF1E3A8A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                                  child: Image.network(
                                    cocktail.thumbnailUrl,
                                    height: 150, // Ukuran gambar
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    cocktail.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
