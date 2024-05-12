import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_9_app/datastructures/bottem_nav_bar.dart';
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
        //Home
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

            //Sub route of home
            routes: [
              GoRoute(
                path: 'product',
                builder: (context, state) => const ProductPage(),
              ),
            ]
          ),

        //Search
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(), 
          
          //Sub routes of search
          routes: [],
          ),

        //Favorites
        GoRoute(
          path: '/favorite',
          builder: (context, state) => const FavoritePage(),
          
          //Sub routes of Product
          routes: [],
        ),

        //Shopping guide
        GoRoute(
          path: '/guide',
          builder: (context, state) => const WinkelGids(),
          
          //Sub routes of Product
          routes: [],
        ),

        //QR code scan
        GoRoute(
          path: '/qrscan',
          builder: (context, state) => const QRPage(),
          
          //Sub routes of Product
          routes: [],
        ),
      ],

      //Bottem navigation
      builder: (context, state, builder) {
        return const BottomNavBar();
      }
    ),
  ]
);