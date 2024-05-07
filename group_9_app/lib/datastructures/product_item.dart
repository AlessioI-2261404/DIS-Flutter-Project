import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.imagePath,
    required this.titel,
    this.rating = 1,
    this.width = 150,
  }) : super(key: key);

  final String titel;
  final String imagePath;
  final int rating;
  final double? width;

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = _isFavoriteFromJson(widget.titel);
  }

  void _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    await _updateFavoritesInJson();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Added to favorites' : 'Removed from favorites',
        ),
      ),
    );
  }

  bool _isFavoriteFromJson(String title) {
    final file = File('Account1.json');
    if (!file.existsSync()) {
      return false;
    }

    final content = file.readAsStringSync();
    if (content.isEmpty) {
      return false;
    }

    Map<String, dynamic> data;
    try {
      data = jsonDecode(content) as Map<String, dynamic>;
    } catch (e) {
      // Handle JSON parsing errors
      return false;
    }

    final favorites = List<Map<String, dynamic>>.from(data['favorites'] ?? []);
    return favorites.any((item) => item['title'] == title);
  }

  Future<void> _updateFavoritesInJson() async {
    final file = File('Account1.json');
    Map<String, dynamic> data = {};

    if (await file.exists()) {
      final content = await file.readAsString();
      try {
        data = jsonDecode(content) as Map<String, dynamic>;
      } catch (e) {
        data = {};
      }
    }

    final favorites = List<Map<String, dynamic>>.from(data['favorites'] ?? []);

    if (isFavorite) {
      if (!favorites.any((item) => item['title'] == widget.titel)) {
        favorites.add({'title': widget.titel, 'imagePath': widget.imagePath});
      }
    } else {
      favorites.removeWhere((item) => item['title'] == widget.titel);
    }

    data['favorites'] = favorites;

    await file.writeAsString(jsonEncode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      color: const Color.fromARGB(255, 10, 133, 237),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: () {
              print("Product tapped");
            },
            child: Column(
              children: [
                SizedBox(
                  width: widget.width,
                  height: 100,
                  child: Image.asset(widget.imagePath, fit: BoxFit.fill),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      widget.titel,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: List.generate(
                    widget.rating,
                    (index) => const Icon(Icons.attach_money),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
