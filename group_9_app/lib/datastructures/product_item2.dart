import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.imagePath,
    required this.titel,
    required this.onTap,
    this.rating = "No rating",
    this.width = 150,
  }) : super(key: key);

  final String titel;
  final String imagePath;
  final VoidCallback onTap;
  final String rating;
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
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 10, 133, 237),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
              children: [
                SizedBox(
                  width: widget.width,
                  height: 210,
                  child: Image.asset(widget.imagePath, fit: BoxFit.fill),
                ),
                const SizedBox(height: 3),
                Flexible(
                  child: Text(
                    widget.titel,
                    style: const TextStyle(color: Colors.white, fontSize: 23),
                    overflow: TextOverflow.ellipsis, // Added overflow handling
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.rating, // Display the rating directly as text
                  style: const TextStyle(color: Colors.white, fontSize: 19),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              iconSize: 40.0, // Increased icon size
              onPressed: _toggleFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: const Color.fromARGB(255, 255, 17, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
