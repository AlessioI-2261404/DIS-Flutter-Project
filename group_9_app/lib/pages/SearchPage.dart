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
                child: Image.asset('images/search/${_imageNames[index]}', fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
    );
  }
}
