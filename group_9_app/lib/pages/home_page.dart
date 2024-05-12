import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:group_9_app/datastructures/product_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.imagePathsBanner,
    required this.imagePathsPopular,
    required this.popularProductNames,
    required this.imagePathsRecommended,
    required this.recommendedProductNames,
  });

  final String title;
  final List<String> imagePathsBanner;
  final List<String> imagePathsPopular;
  final List<String> popularProductNames;
  final List<String> imagePathsRecommended;
  final List<String> recommendedProductNames;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentImg = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildCarouselSlider(),
          ),
          SliverToBoxAdapter(
            child: _buildSectionTitle("Popular"),
          ),
          SliverToBoxAdapter(
            child: _buildHorizontalList(widget.imagePathsPopular, widget.popularProductNames),
          ),
          SliverToBoxAdapter(
            child: _buildSectionTitle("Recommended"),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final productName = widget.recommendedProductNames[index];
                return ProductItem(
                  imagePath: widget.imagePathsRecommended[index],
                  titel: productName,
                  onTap: () { context.goNamed("product"); },
                  width: 160,
                );
              },
              childCount: widget.imagePathsRecommended.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 35,
            ),
          ),
        ],
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

  Widget _buildHorizontalList(List<String> imagePaths, List<String> titles) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            final productName = titles[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ProductItem(
                imagePath: imagePaths[index],
                titel: productName,
                onTap: () => context.goNamed("product"),
              ),
            );
          },
        ),
      ),
    );
  }
}
