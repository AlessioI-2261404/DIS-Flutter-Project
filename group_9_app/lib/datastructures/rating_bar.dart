
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:group_9_app/datastructures/product.dart';

class RatingBar extends StatefulWidget{
  const RatingBar({super.key, required this.product});
  final String product;

  @override
  State<StatefulWidget> createState() => _RatingBarState();
}



class _RatingBarState extends State<RatingBar> {
  int rating = 0;

  bool _isAboveOrEqual(int a, int b){
    return a <= b;
  }

  void _selectrating(int index) {
    setState(() {
      if (rating == (index + 1)) { rating = -1; }
      else { rating = (index + 1); }
    });
  }

  List<Widget> _createRating() {
    List<Widget> rate = [];
    for (int i = 0; i < 5; i++ ){
      bool isRated = _isAboveOrEqual((i+1), rating);

      rate.add(InkWell(
        child: Icon(
          isRated? Icons.grade : Icons.grade_outlined,
          size: 35,
          color: isRated? Colors.yellow : Colors.black,
        ),

        onTap: () => _selectrating(i),
      ));
    }

    return rate;
  }

  Future<void> _write_rating() async {
    final file = File('Account1.json');
    Map<String, dynamic> data = {};

    //Check if file exists
    if (await file.exists()) {
      final content = await file.readAsString();
      try {
        data = jsonDecode(content) as Map<String, dynamic>;
      } catch (e) {
        data = {};
      }
    }

    //Get current file data
    final String name = widget.product;
    final ratings = List<Map<String, dynamic>>.from(data['ratings'] ?? []);

    bool found = false;
    if (ratings.isNotEmpty){
      found = ratings.any((element) => (element['name'] == widget.product));
    }

    //We remove previous rating
    if (found) {
      ratings.removeWhere((item) => item['name'] == widget.product);
    }

    //write new rating to json
    ratings.add({"name":name, "rating":rating});
    data['ratings'] = ratings;
    await file.writeAsString(jsonEncode(data));
  }

  void _addRating() async{
    if (rating > 0) { 
      await _write_rating(); 

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Review is toegevoegd',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children : _createRating(), 
          ),
        const SizedBox(height: 20,),
        TextButton(
          onPressed: () => _addRating(), 
          child: const Text("voeg review toe")
        ),
        const SizedBox(height: 35,),
      ],
    );
  }
}