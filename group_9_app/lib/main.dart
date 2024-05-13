import 'package:flutter/material.dart';
import 'package:group_9_app/Router/router.dart';
import 'dart:convert';
import 'dart:io';


void main() {
  runApp(const MyApp());
  createEmptyJsonFile();
}

void createEmptyJsonFile() async {
  final Map<String, dynamic> jsonData = {
    'favoriteCategories': [],
    'favorites': [],
    'accountDetails': {
      'email': 'test@test.com',
      'username': 'test_user',
      'password': 123456, 
      'cameraAccess': true,
      'locationAccess': true,
    },
    'pfppicpath': 'picture.jpg',
  };

  final file = File('Account1.json');
  await file.writeAsString(jsonEncode(jsonData));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 38, 255)),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}