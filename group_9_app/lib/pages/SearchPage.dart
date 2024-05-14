import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:group_9_app/datastructures/product.dart';
import 'package:group_9_app/datastructures/product_item2.dart';
import 'package:group_9_app/pages/product_page.dart';

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
  String? _suggestedQuery;
  List<Product> products = [];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  final List<String> _imageNames = [
    'Barbie.png',
    'HotWheels.jpg',
    'Lego.png',
    'StarWars.jpg',
  ];

  Future<void> loadProducts() async {
    final file = File('Product.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      if (jsonData is List) {
        var loadedProducts = jsonData.map((productJson) => Product.fromJson(productJson)).toList();
        setState(() {
          products = loadedProducts;
        });
        print('loaded products');
      }
    } else {
      print('Product file does not exist');
    }
  }

  void _filterProducts(String query) {
    final filtered = products.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      filteredProducts = filtered;
    });

    if (filtered.isEmpty) {
      _suggestAutocorrect(query);
    } else {
      setState(() {
        _suggestedQuery = null;
      });
    }
  }

  void _suggestAutocorrect(String query) {
    String? closestMatch;
    int minDistance = query.length;

    for (var product in products) {
      int distance = _levenshteinDistance(query.toLowerCase(), product.name.toLowerCase());
      if (distance < minDistance) {
        minDistance = distance;
        closestMatch = product.name;
      }
    }

    if (closestMatch != null && minDistance <= 20) { 
      setState(() {
        _suggestedQuery = closestMatch;
      });
    } else {
      setState(() {
        _suggestedQuery = null;
      });
    }
  }

  int _levenshteinDistance(String s1, String s2) {
    final len1 = s1.length;
    final len2 = s2.length;
    List<List<int>> dp = List.generate(len1 + 1, (i) => List.filled(len2 + 1, 0));

    for (int i = 0; i <= len1; i++) {
      for (int j = 0; j <= len2; j++) {
        if (i == 0) {
          dp[i][j] = j;
        } else if (j == 0) {
          dp[i][j] = i;
        } else if (s1[i - 1] == s2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 + [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]].reduce((a, b) => a < b ? a : b);
        }
      }
    }

    return dp[len1][len2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
                _filterProducts(value);
                _isHelloVisible = value.isNotEmpty;
              });
            },
            onSubmitted: (value) => setState(() => _isHelloVisible = true),
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 63, 148, 223)),
            ),
          ),
        ),
        if (_suggestedQuery != null) _buildSuggestion(),
        Expanded(
          child: _isHelloVisible
              ? _searchQuery.isNotEmpty ? _buildProductGrid() : Center(child: Text('Oei er is niks te vinden, probeer iets anders op te zoeken!'))
              : _buildImageList(),
        ),
      ],
    );
  }

  Widget _buildSuggestion() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchQuery = _suggestedQuery!;
          _filterProducts(_searchQuery);
          _isHelloVisible = true;
          _suggestedQuery = null;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Wrap(
          children: [
            Text('Do you mean: ', style: TextStyle(color: Colors.grey)),
            Text(
              _suggestedQuery!,
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ProductItem(
            imagePath: product.mainImage,
            titel: product.name,
            rating: product.abstractPrice,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductPage(name: product.name, theItem: product),
              ));
            },
            width: MediaQuery.of(context).size.width,
          ),
        );
      },
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
                child: Image.asset('images/search/${_imageNames[index]}', fit: BoxFit.fill),
              ),
            ),
          ),
        );
      },
    );
  }
}
