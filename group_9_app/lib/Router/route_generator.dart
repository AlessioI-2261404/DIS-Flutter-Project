import 'package:flutter/material.dart';
import 'package:group_9_app/pages/home_page.dart';
import 'package:group_9_app/pages/product_page.dart';
import 'package:group_9_app/pages/SearchPage.dart';
import 'package:group_9_app/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/product':
        return MaterialPageRoute(builder: (_) => const ProductPage());
      case '/search':
        return MaterialPageRoute( builder: (_) => const SearchPage());
      default: 
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}