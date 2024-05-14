import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.imagePath,
    required this.titel,
    required this.onTap,
    this.rating = "Geen beoordeling",
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
          isFavorite ? 'Toegevoegd aan favorieten' : 'Verwijderd uit favorieten',
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
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                SizedBox(
                  width: widget.width,
                  height: 90,
                  child: Image.asset(widget.imagePath, fit: BoxFit.fill), 
                ),
                const SizedBox(height: 3),
                Flexible(
                  child: Text(
                    widget.titel,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis, 
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.rating, 
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            child: IconButton(
              iconSize: 25.0, // Increased icon size
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
