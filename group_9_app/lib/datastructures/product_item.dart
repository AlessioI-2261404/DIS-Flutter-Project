import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ProductItem extends StatelessWidget{
  ProductItem({
    super.key,
    required this.imagePath,
    required this.titel,
    this.rating = 1,
    this.width = 150,
    this.onTap,
    });

  VoidCallback? onTap;
  String titel;
  String imagePath;
  int rating;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: const Color.fromARGB(255, 10, 133, 237),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              SizedBox(width: width, height: 100, child: Image.asset(imagePath, fit: BoxFit.fill,)),

              const SizedBox(height: 3),

              Row(
                children: [
                Text(titel, style: const TextStyle(color: Colors.white, fontSize: 20)),
              ],),
              
              const SizedBox(height: 5),

              Row(
                children : _createChilderen(),
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),

        ],
      ),
    );
  }

  List<Widget> _createChilderen() {
    return List<Widget>.generate(rating, (index) => const Icon(Icons.attach_money));
  }

}