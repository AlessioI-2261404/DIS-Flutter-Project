import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/FavoritesPage.dart';
import 'pages/SearchPage.dart';
import 'pages/WinkelGids.dart';
import 'pages/QRpage.dart';

void main() {
  runApp(const MyApp());
  createEmptyJsonFile();
}

void createEmptyJsonFile() async {
  final Map<String, dynamic> jsonData = {
    'favoriteCategories': ["BARBIE"],
    'favorites': [],
    'accountDetails': {
      'email': 'test@test.com',
      'username': 'test_user',
      'password': 123456,
      'cameraAccess': true,
      'locationAccess': false,
    },
    'pfppicpath': 'images/home/Background.png',
    'ratings': [],
    'stories': [],
  };

  final file = File('Account1.json');
  await file.writeAsString(jsonEncode(jsonData));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 38, 255)),
        useMaterial3: true,
      ),
      home: 
      const Center(
        child: SizedBox(
          width: 295,
          height: 640,
          child: BottomNavBar(),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const MyHomePage(imagePathsBanner: ['images/home/Banner/Aanbieding1.png', 'images/home/Banner/SuperDeals.jpg']);
      case 1:
        return const SearchPage();
      case 2:
        return const FavoritePage();
      case 3:
        return const WinkelGids();
      default:
        return const Center(child: Text("Page not found"));
    }
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _checkLocationAccess(context);
    } else if (index == 4) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QRPage()));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _checkLocationAccess(BuildContext localContext) async {
    final file = File('Account1.json');
    final contents = await file.readAsString();
    final jsonData = jsonDecode(contents);
    bool locationAccess = jsonData['accountDetails']['locationAccess'] as bool;

    if (locationAccess) {
      setState(() {
        _selectedIndex = 3; // Navigate to WinkelGids if location access is enabled
      });
    } else {
      if (!mounted) return;
      showDialog(
        context: localContext,
        builder: (BuildContext dialogContext) => AlertDialog(
          title: const Text('Location Required'),
          content: const Text('You can\'t use this function without enabling your location. Do you want to enable it?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                jsonData['accountDetails']['locationAccess'] = true;
                file.writeAsString(jsonEncode(jsonData));
                Navigator.of(dialogContext).pop();
                if (!mounted) return;
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 63, 148, 223),
      unselectedItemColor: Colors.grey,
      selectedItemColor: const Color.fromARGB(255, 0, 38, 255),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Like List'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'WinkelGids'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Qr Scan'),
      ],
    );
  }
}
