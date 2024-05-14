
import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget{
  const RatingBar({super.key});

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

  void _addRating() {
    //add rating to database
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