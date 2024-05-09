import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//navbar: headpages
import 'package:group_9_app/pages/home_page.dart';
import 'package:group_9_app/pages/SearchPage.dart';
import 'package:group_9_app/pages/FavoritesPage.dart';
import 'package:group_9_app/pages/WinkelGids.dart';
import 'package:group_9_app/pages/QRpage.dart';
//- subpages:
import 'package:group_9_app/pages/product_page.dart';

GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MyHomePage(
              title: 'Home Page',
              imagePathsBanner: ['images/home/Banner/Aanbieding1.png', 'images/home/Banner/SuperDeals.jpg'], // banner images
              imagePathsPopular: ['images/home/Popular/YodaFigure.jpg', 'images/home/Popular/BarbiePulsBeryDollSet.jpg'], // popular images
              popularProductNames: ["Yoda Figuur 1", "Barbie 2.0"], // product names
              imagePathsRecommended: ['images/home/Recommended/LegoDeathStar.jpg', 'images/home/Recommended/LegoDeathStar.jpg'], // recommended images
              recommendedProductNames: ['Lego Death Star', 'Lego Death Star'], // recommended product names
            ),
            routes: [
              GoRoute(
                path: 'product',
                builder: (context, state) => const ProductPage(),
              ),
            ]
          ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(), 
          ),
        GoRoute(
          path: '/product',
          builder: (context, state) => const ProductPage(),
        )
      ],
      builder: (context, state, builder) {
        return const BottomNavBar();
      }
    ),
  ]
);




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
      imagePathsBanner: ['images/home/Banner/Aanbieding1.png', 'images/home/Banner/SuperDeals.jpg'], // banner images
      imagePathsPopular: ['images/home/Popular/YodaFigure.jpg', 'images/home/Popular/BarbiePulsBeryDollSet.jpg'], // popular images
      popularProductNames: ["Yoda Figuur 1", "Barbie 2.0"], // product names
      imagePathsRecommended: ['images/home/Recommended/LegoDeathStar.jpg', 'images/home/Recommended/LegoDeathStar.jpg'], // recommended images
      recommendedProductNames: ['Lego Death Star', 'Lego Death Star'], // recommended product names
    ),
    const SearchPage(),
    const FavoritePage(),
    const WinkelGids(),
    const QRPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Updates the displayed page
      bottomNavigationBar: _buildBottomNavigationBar(), // update bottom navigation
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
