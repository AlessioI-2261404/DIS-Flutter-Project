import 'package:flutter/material.dart';

class CompareItem extends StatelessWidget{
  const CompareItem({super.key});

  void _goToProduct() {
    //todo
  }

  @override
  Widget build(Object context) {
    return InkWell(
      onTap: _goToProduct,
      child: SizedBox(
        width: 90,
        height: 150,
        child: Image.asset('images/home/YodaFigure.jpg', fit: BoxFit.fill,),
      ),
    );
  }
}