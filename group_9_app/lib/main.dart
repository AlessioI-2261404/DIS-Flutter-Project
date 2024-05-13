import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/FavoritesPage.dart';
import 'pages/SearchPage.dart';
import 'pages/WinkelGids.dart';
import 'pages/QRpage.dart';
import 'pages/product_page.dart';
import 'pages/ProfilePage.dart';

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
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 38, 255)),
        useMaterial3: true,
      ),
      home: const Center(
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
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MyHomePage(
      title: 'Home Page',
      imagePathsBanner: ['images/home/Banner/Aanbieding1.png', 'images/home/Banner/SuperDeals.jpg'],
      imagePathsPopular: ['images/home/Popular/YodaFigure.jpg', 'images/home/Popular/BarbiePulsBeryDollSet.jpg'],
      popularProductNames: ["Yoda Figuur 1", "Barbie 2.0"],
      imagePathsRecommended: ['images/home/Recommended/LegoDeathStar.jpg', 'images/home/Recommended/LegoDeathStar.jpg'],
      recommendedProductNames: ['Lego Death Star', 'Lego Death Star'],
    ),
    const SearchPage(),
    const FavoritePage(),
    const WinkelGids(),
  ];

  void _onItemTapped(int index) {
    if (index == 4) { // QR Scan tab
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const QRPage(),
      ));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
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
