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
      home: const SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 1;
  bool _isHelloVisible = false;
  String _searchQuery = '';

  final List<String> _imageNames = [
    'Barbie.png',
    'HotWheels.jpg',
    'Lego.png',
    'StarWars.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Page')),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            onSubmitted: (value) => setState(() => _isHelloVisible = true),
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 63, 148, 223)),
            ),
          ),
        ),
        Expanded(
          child: _isHelloVisible
              ? Center(child: Text(_searchQuery.isNotEmpty ? _searchQuery : 'Hello'))
              : _buildImageList(),
        ),
      ],
    );
  }

  Widget _buildImageList() {
    return ListView.builder(
      itemCount: _imageNames.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => setState(() => _isHelloVisible = true),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: const Color.fromARGB(255, 63, 148, 223)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child: Image.asset('assets/images/${_imageNames[index]}', fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
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
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Like List'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'WinkelGids'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Qr Scan'),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isHelloVisible = index == 1 ? false : _isHelloVisible;
      _searchQuery = index == 1 ? '' : _searchQuery;
    });
  }
}
