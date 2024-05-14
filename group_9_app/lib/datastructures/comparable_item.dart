import 'package:flutter/material.dart';

class CompareItem extends StatelessWidget {
  final String imagePath;
  final String productName;
  final VoidCallback onTap;

  const CompareItem({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            width: 90,
            height: 100,
            child: Image.asset(imagePath, fit: BoxFit.fill),
          ),
          Text(productName, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
