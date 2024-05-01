import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 63, 148, 223)),
      ),
      home: const FavoritePage(),
    );
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _selectedIndex = 2; // Index of the favorite page in the bottom navigation bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 159, 237), // Blue color
        title: const Text('Jouw favorieten'),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            // Handle profile icon tap
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Handle share button tap
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Geen favorieten in je lijst',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 63, 148, 223),
      unselectedItemColor: Colors.grey,
      selectedItemColor: const Color.fromARGB(255, 63, 148, 223),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'WinkelGids'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Qr Scan'),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
