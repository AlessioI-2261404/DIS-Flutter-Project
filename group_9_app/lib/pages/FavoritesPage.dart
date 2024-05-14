import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> _favorites = [];
  late Map<String, dynamic> _jsonData;

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

      // Explicitly cast the data to Map<String, dynamic>
      _jsonData = Map<String, dynamic>.from(data);

      if (_jsonData.containsKey('favorites')) {
        setState(() {
          _favorites = List<Map<String, dynamic>>.from(_jsonData['favorites']);
        });
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 159, 237),
        title: const Text('Je favorieten'),
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Text(
                'Geen favorieten in je lijst',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final item = _favorites[index];
                return ListTile(
                  leading: Image.asset(item['imagePath']),
                  title: Text(item['title']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _confirmRemove(item),
                  ),
                );
              },
            ),
    );
  }
}
