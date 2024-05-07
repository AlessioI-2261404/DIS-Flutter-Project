import 'package:flutter/material.dart';

class ImageIndex extends StatelessWidget {
  const ImageIndex({
    super.key, 
    required this.path,
    required this.opacity,
    });

  final String path;
  final double opacity; // = 0.6;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset(path, fit: BoxFit.fill, opacity: AlwaysStoppedAnimation(opacity),),
    );
  }
}
