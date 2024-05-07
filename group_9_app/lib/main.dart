import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/product_page.dart';

void main() {
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group 9 app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 38, 255)),
        useMaterial3: true,
      ),
      home: const ProductPage() //(title: 'Flutter Demo Home Page'),
    );
  }
}