import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:group_9_app/datastructures/product_item.dart';
import '../datastructures/home_page_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentImg = 0;
  int _selectedIndex = 0;

  void foo() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/home/Background.png"), 
            fit: BoxFit.cover
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
          
                //Superdeals
                Stack(
                  alignment: Alignment.center,
                  children: [
                    //deals
                    CarouselSlider(
                      items: HomePageData.imagePathsBanner.map((imgPath) { 
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(imgPath, fit: BoxFit.fill),
                        ); }).toList(),
                        options: CarouselOptions(
                          height: 290,
                          viewportFraction: 1,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentImg = index;
                            });
                          },
                        )),
                    
                    //Indicators
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.025,
                      child: Row(
                        children: List.generate(HomePageData.imagePathsBanner.length, 
                        (index) {
                            bool isSelected = (currentImg == index);
                            return AnimatedContainer(
                              width: 12,
                              height: 12,
                              margin: EdgeInsets.symmetric(horizontal: isSelected? 6 : 3 ),
                              decoration: BoxDecoration(
                                color: isSelected? const Color.fromARGB(141, 202, 202, 243): const Color.fromARGB(153, 0, 0, 0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              duration: const Duration(milliseconds: 600),
                            );
                          }),
                      ))
                    
                  ],
                ),
                
                //The page with the recommended products
                 Padding(
                  padding: const EdgeInsets.only(top: 65),
                  child: Column(
                    children: [
                      const Text(
                        "Populair",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      
                      const SizedBox(height: 10),
        
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: SizedBox(
                          height: 170,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => ProductItem(imagePath: HomePageData.imagePathsPopular[index], 
                              titel: HomePageData.populairProductName[index]),
                            itemCount: HomePageData.imagePathsPopular.length,
                            separatorBuilder: (context, index) => const SizedBox(width: 30),
                          ),
                        ),
                      ),
        
                      const SizedBox(height: 35),
        
                      const Text(
                        "Aanbevolen",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                
                      SizedBox(
                        height: 700,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing:  30,
                            crossAxisSpacing: 35,
                            children: _createRecommendedItems(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildBottomNavigationBar(),
          ],
      ),
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
    });
  }
  
  List<Widget> _createRecommendedItems() {
    return List<Widget>.generate(HomePageData.imagePathsRecommended.length, (index) {
      return ProductItem(imagePath: HomePageData.imagePathsRecommended[index],
                  titel: HomePageData.RecommendedProductName[index],
                  width: 180,);
    });
  }
}


          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.