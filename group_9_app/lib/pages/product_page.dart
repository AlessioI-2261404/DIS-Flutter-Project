import 'package:flutter/material.dart';
import 'package:group_9_app/datastructures/rating_bar.dart';
import 'package:group_9_app/datastructures/product.dart';
import 'package:group_9_app/datastructures/story_item.dart';
import 'package:group_9_app/pages/add_story_page.dart';
import 'package:group_9_app/pages/ARpage.dart';
import 'dart:convert';
import 'dart:io';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.name, required this.theItem});
  final String name;
  final Product theItem;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ValueNotifier<String> imgHead = ValueNotifier('images/home/Recommended/LegoDeathStar.jpg');
  final ScrollController _controller = ScrollController();
  bool liked = false;
  int selected = 0;
  int rating = 0;

  @override
  void initState() {
    super.initState();
    imgHead.value = widget.theItem.mainImage; 
    liked = _isFavoriteFromJson(widget.name);
    setupRating();
  }

  void setupRating() async {
    await _lookupRating();
    setState(() {});
  }

  bool _isFavoriteFromJson(String title) {
    final file = File('Account1.json');
    if (!file.existsSync()) {
      return false;
    }

    final content = file.readAsStringSync();
    if (content.isEmpty) {
      return false;
    }

    Map<String, dynamic> data;
    try {
      data = jsonDecode(content) as Map<String, dynamic>;
    } catch (e) {
      return false;
    }

    final favorites = List<Map<String, dynamic>>.from(data['favorites'] ?? []);
    return favorites.any((item) => item['title'] == title);
  }

  Future<void> _updateFavoritesInJson() async {
    final file = File('Account1.json');
    Map<String, dynamic> data = {};

    if (await file.exists()) {
      final content = await file.readAsString();
      try {
        data = jsonDecode(content) as Map<String, dynamic>;
      } catch (e) {
        data = {};
      }
    }

    final favorites = List<Map<String, dynamic>>.from(data['favorites'] ?? []);

    if (liked) {
      if (!favorites.any((item) => item['title'] == widget.name)) {
        favorites.add({'title': widget.name, 'imagePath': widget.theItem.mainImage});
      }
    } else {
      favorites.removeWhere((item) => item['title'] == widget.name);
    }

    data['favorites'] = favorites;

    await file.writeAsString(jsonEncode(data));
  }

  void _navigateBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void _navigateToARPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ARPage()));
  }

  void _toggleFavorite() async {
    setState(() {
      liked = !liked;
    });

    await _updateFavoritesInJson();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(liked ? 'Added to favorites' : 'Removed from favorites'),
      ),
    );
  }

  Future<List<Product>> fetchMatchingProducts() async {
    final file = File('Product.json');
    if (!await file.exists()) {
      print('File not found');
      return [];
    }
    final jsonString = await file.readAsString();
    final List<dynamic> productJson = jsonDecode(jsonString);
    List<Product> products = productJson.map((json) => Product.fromJson(json)).toList();

    List<Product> matchingProducts = products.where((product) {
      return product.category.any(widget.theItem.category.contains);
    }).toList();

    return matchingProducts;
  }

  Future<void> _lookupRating() async{
    int userRating = await _lookupRatingUser();

    if (userRating == -1) { rating = widget.theItem.rate; }
    else {
      int totalRating = ((userRating + widget.theItem.rate) / 2).round();
      rating = totalRating;
    }
  }

  Future<int> _lookupRatingUser() async {
    final file = File('Account1.json');
    Map<String, dynamic> data = {};

    //Check if file exists
    if (await file.exists()) {
      final content = await file.readAsString();
      try {
        data = jsonDecode(content) as Map<String, dynamic>;
      } catch (e) {
        data = {};
      }
    }

    //Get ratings data
    final String name = widget.theItem.name;
    final ratings = List<Map<String, dynamic>>.from(data['ratings'] ?? []);

    //look for rating
    bool found = false;
    int rate = -1;

    if (ratings.isNotEmpty){
      found = ratings.any((element) {
        bool f = (element['name'] == name);
        if (f) { rate = element['rating']; }
        return f;
      });
    }

    return rate;
  }

  List<Widget> _buildStories() {
    if (widget.theItem.stories.isEmpty) {
      // If there are no stories, return a single widget with a message
      return [const Text("No stories yet.", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic))];
    } else {
      // Otherwise, generate widgets based on the stories
      return List<Widget>.generate(widget.theItem.stories.length, (index) {
        return Row(
          children: [
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 100,
                width: 90,
                child: StoryItem(type: widget.theItem.stories[index].type, 
                                 headerImg: widget.theItem.stories[index].header, 
                                 file: widget.theItem.stories[index].file),
              )
            ),
            const SizedBox(width: 15,)
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/home/Background.png"),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 5),
              _buildTopBar(),
              const SizedBox(height: 10),
              Expanded(
                child: _buildProductDetails()
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: _navigateBack, icon: const Icon(Icons.keyboard_return), iconSize: 40),
        const SizedBox(width: 15),
        Flexible(child: Text(widget.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 25))),
        const SizedBox(width: 15),
        IconButton(onPressed: () {}, icon: const Icon(Icons.share), iconSize: 40),  // Share functionality to be implemented
      ],
    );
  }

  Widget _buildProductDetails() {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildProductImage(rating),
            const SizedBox(height: 25),
            _buildImageNavigation(widget.theItem.subImages),
            const SizedBox(height: 25),
            _buildPurchaseRow(),
            _buildDescription(),
            const SizedBox(height: 20),
            _buildStoriesSection(),
            const SizedBox(height: 45),
            _buildComparableProductsSection(),
            const SizedBox(height: 45),
            RatingBar(product: widget.theItem.name, refresh: setupRating),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(int rating) {
    return ValueListenableBuilder<String>(
      valueListenable: imgHead,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.topLeft,
          children: [
            SizedBox(
              width: 260,
              height: 200,
              child: Image.asset(value, fit: BoxFit.fill), // Use 'value' which is the current image path
            ),
            Positioned(
              top: 0.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<Widget>.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.grade : Icons.grade_outlined,
                      size: 25,
                      color: index < rating ? Colors.yellow : null,
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageNavigation(final List<String> subImages) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (selected > 0) {
                _controller.jumpTo((selected - 1) * 70.0);
                setState(() {
                  selected = selected - 1;
                  imgHead.value = subImages[selected];  
                });
              }
            },
            child: const CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black38,
              child: Icon(Icons.arrow_left),
            ),
          ),
          SizedBox(
            width: 220,
            height: 70,
            child: ListView.separated(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, index) => const SizedBox(width: 10),
              itemCount: subImages.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selected = index;
                      imgHead.value = subImages[index];  
                    });
                  },
                  child: Opacity(
                    opacity: selected == index ? 1.0 : 0.6,
                    child: Image.asset(subImages[index], fit: BoxFit.fill),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              if (selected < subImages.length - 1) {
                _controller.jumpTo((selected + 1) * 70.0);
                setState(() {
                  selected = selected + 1;
                  imgHead.value = subImages[selected];  // Update main image
                });
              } else {
                _controller.jumpTo(0);
                setState(() {
                  selected = 0;
                  imgHead.value = subImages[0];  // Wrap around to the first image
                });
              }
            },
            child: const CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black38,
              child: Icon(Icons.arrow_right),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseRow() {
    return Row(
      children: [
        const SizedBox(width: 40),
        const Icon(Icons.attach_money, size: 23),
        Text(widget.theItem.exactPrice.toString(), style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 60),
        IconButton(onPressed: _navigateToARPage, icon: const Icon(Icons.view_in_ar, size: 45)),
        IconButton(
          onPressed: _toggleFavorite,
          icon: liked
              ? const Icon(Icons.favorite, size: 45, color: Colors.red)
              : const Icon(Icons.favorite_border, size: 45),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ExpansionTile(
        title: const Text("Description"),
        subtitle: const Text("klik hier om meer te zien over het product."),
        children: [
          widget.theItem.description.isNotEmpty 
            ? Text(widget.theItem.description, style: const TextStyle(fontSize: 14))
            : const Text("Geen beschrijving voor dit product.", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildStoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Stories", style: TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 7.0),
          child: SizedBox(
            height: 100,
            width: 270,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _buildStories(),
            ),
          ),
        ),

        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddStoryPage(product: widget.name)
              ));
            }, 
            child: const Text("Voeg verhaal toe")),
        ),
      ],
    );
  }

  Widget _buildComparableProductsSection() {
    return FutureBuilder<List<Product>>(
      future: fetchMatchingProducts(), // Call the async function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show an error message if an error occurs
        } else if (snapshot.hasData) {
          final products = snapshot.data!;
          if (products.isEmpty) {
            // Show a message if no comparable products are found
            return const Text('Geen vergelijkbare speelgoed gevonden', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic));
          } else {
            // Return the column with dynamically built comparable products
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Vergelijkbare Speelgoed", style: TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SizedBox(
                    width: 400,
                    height: 130,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, index) => const SizedBox(width: 10),
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        return CompareItem(product: products[index],); // Assuming CompareItem takes a Product object
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        } else {
          return const Text('No data'); // Fallback if no data is available
        }
      },
    );
  }
}

class CompareItem extends StatelessWidget {
  final Product product;

  const CompareItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductPage(name: product.name, theItem: product)
        ));
      },
      child: Column(
        children: [
          Image.asset(product.mainImage, fit: BoxFit.fill, width: 90, height: 100),
          SizedBox(
            width: 100,
            child: Flexible(
              child: Text(
                product.name, 
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                )
            ),
          ),
        ],
      ),
    );
  }
}
