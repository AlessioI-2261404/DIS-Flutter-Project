import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:group_9_app/datastructures/product.dart';
import 'package:group_9_app/datastructures/product_item.dart';
import 'package:group_9_app/pages/product_page.dart';
import 'package:group_9_app/pages/profile_choose.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.imagePathsBanner,
  }) : super(key: key);

  final List<String> imagePathsBanner;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentImg = 0;
  List<Product> products = [];
  List<Product> popularProducts = [];
  List<Product> recommendedProducts = [];
  String profilePicPath = 'images/Default_pfp.png'; // Default profile picture

  @override
  void initState() {
    super.initState();
    loadProfilePicture();
    loadProducts();
  }

  Future<void> loadProfilePicture() async {
    final file = File('Account1.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      setState(() {
        profilePicPath = jsonData['pfppicpath'] ?? 'images/Default_pfp.png';
      });
    } else {
      print('Account preferences file does not exist');
    }
  }

  Future<void> loadProducts() async {
    final file = File('Product.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      if (jsonData is List) {
        var loadedProducts = jsonData.map((productJson) => Product.fromJson(productJson)).toList();
        setState(() {
          products = loadedProducts;
          popularProducts = loadedProducts.where((product) => product.status.toLowerCase() == 'popular').toList();
        });
      }
    } else {
      print('Product file does not exist');
    }
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final file = File('Account1.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      List<String> favoriteCategories = List<String>.from(jsonData['favoriteCategories']);
      setState(() {
        recommendedProducts = products.where((product) =>
          product.category.any((category) => favoriteCategories.contains(category))
        ).toList();
      });
    } else {
      print('Account preferences file does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildCarouselSlider()),
              SliverToBoxAdapter(child: _buildSectionTitle("populaire items")),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final theItem = popularProducts[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ProductItem(
                        rating: theItem.abstractPrice,
                        imagePath: theItem.mainImage,
                        titel: theItem.name,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductPage(name: theItem.name, theItem: theItem)
                          ));
                        },
                        width: 160,
                      ),
                    );
                  },
                  childCount: popularProducts.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 30,
                ),
              ),
              SliverToBoxAdapter(child: _buildSectionTitle("Aangeraden items")),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final theItem = recommendedProducts[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductItem(
                        rating: recommendedProducts[index].abstractPrice,
                        imagePath: recommendedProducts[index].mainImage,
                        titel: recommendedProducts[index].name,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductPage(name: theItem.name, theItem: theItem)
                          ));
                        },
                        width: 160,
                      ),
                    );
                  },
                  childCount: recommendedProducts.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: _buildProfilePicture(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileChoose(),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(profilePicPath),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          items: widget.imagePathsBanner.map((imgPath) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(imgPath, fit: BoxFit.fill),
            );
          }).toList(),
          options: CarouselOptions(
            height: 290,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentImg = index;
              });
            },
          ),
        ),
        if (widget.imagePathsBanner.isNotEmpty)
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.imagePathsBanner.length, (index) {
                return AnimatedContainer(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: currentImg == index
                        ? const Color.fromARGB(141, 202, 202, 243)
                        : const Color.fromARGB(153, 0, 0, 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  duration: const Duration(milliseconds: 600),
                );
              }),
            ),
          ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildHorizontalList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: popularProducts.length,
          itemBuilder: (context, index) {
            final theProduct = popularProducts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ProductItem(
                rating: theProduct.abstractPrice,
                imagePath: theProduct.mainImage,
                titel: theProduct.name,
                onTap: () {
                  print(theProduct.name);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}