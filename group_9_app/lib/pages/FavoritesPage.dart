import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:group_9_app/datastructures/product.dart';
import 'package:group_9_app/datastructures/product_item3.dart';
import 'package:group_9_app/pages/product_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> _favorites = [];
  late Map<String, dynamic> _jsonData;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final file = File('Account1.json');

    if (await file.exists()) {
      final content = await file.readAsString();
      final data = jsonDecode(content) as Map<dynamic, dynamic>;

      _jsonData = Map<String, dynamic>.from(data);

      if (_jsonData.containsKey('favorites')) {
        setState(() {
          _favorites = List<Map<String, dynamic>>.from(_jsonData['favorites']);
        });
        await _loadProducts();
      }
    }
  }

  Future<void> _loadProducts() async {
    final file = File('Product.json');

    if (await file.exists()) {
      final content = await file.readAsString();
      final List<dynamic> productList = jsonDecode(content);

      // Get the favorite product names
      final favoriteNames = _favorites.map((fav) => fav['title']).toSet();

      // Filter products that are in the favorites list
      _products = productList
          .where((productJson) => favoriteNames.contains(productJson['name']))
          .map((productJson) => Product.fromJson(productJson))
          .toList();

      setState(() {});
    }
  }

  Future<void> _removeFavorite(Map<String, dynamic> item) async {
    final file = File('Account1.json');

    _favorites.remove(item);
    _jsonData['favorites'] = _favorites;

    await file.writeAsString(jsonEncode(_jsonData));

    setState(() {});
  }

  void _confirmRemove(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bevestig Verwijderen'),
          content: const Text('Weet u zeker dat u dit item uit uw favorieten wilt verwijderen?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuleren'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _removeFavorite(item);
              },
              child: const Text('Verwijderen'),
            ),
          ],
        );
      },
    );
  }

  void _showSharePopup() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your product is shared!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 159, 237),
        title: const Text('Je favorieten'),
        actions: [
          IconButton(
            iconSize: 30.0,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0, top: 0.0, bottom: 0.0),
            icon: const Icon(Icons.share),
            onPressed: _showSharePopup,
          ),
        ],
      ),
      body: _products.isEmpty
          ? Center(
              child: Text(
                'Geen favorieten in je lijst',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.83,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final theItem = _products[index];
                return ProductItem(
                  rating: theItem.abstractPrice,
                  imagePath: theItem.mainImage,
                  titel: theItem.name,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductPage(name: theItem.name, theItem: theItem),
                    ));
                  },
                  width: 160,
                );
              },
            ),
    );
  }
}
