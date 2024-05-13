import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_9_app/datastructures/bottem_nav_bar.dart';
//navbar: headpages
import 'package:group_9_app/pages/home_page.dart';
import 'package:group_9_app/pages/SearchPage.dart';
import 'package:group_9_app/pages/FavoritesPage.dart';
import 'package:group_9_app/pages/WinkelGids.dart';
import 'package:group_9_app/pages/QRpage.dart';
import 'package:group_9_app/pages/page_wrapper.dart';
//- subpages:
import 'package:group_9_app/pages/product_page.dart';


class AppRouter {
  AppRouter._();

  static String initR = '/home';

  //keys
  static final _rootKey = GlobalKey<NavigatorState>();
  static final _rootHomeKey = GlobalKey<NavigatorState>(debugLabel: 'debug label router');
  static final _rootSearchKey = GlobalKey<NavigatorState>(debugLabel: 'Search key debug');
  static final _rootFavoritesKey = GlobalKey<NavigatorState>(debugLabel: 'root favorites debug');
  static final _rootGuideKey = GlobalKey<NavigatorState>(debugLabel: 'root favorites debug');
  static final _rootQRKey = GlobalKey<NavigatorState>(debugLabel: 'root favorites debug');

  // Go router config
  static final GoRouter router = GoRouter(
    initialLocation: initR,
    navigatorKey: _rootKey,
    routes: <RouteBase>[

      // Page wrapper Route
      StatefulShellRoute.indexedStack(
        builder:(context, state, navigationShell) {
          return PageWrapper(navShell: navigationShell);
        },
        branches: <StatefulShellBranch>[

          //Branch home
          StatefulShellBranch(
            navigatorKey: _rootHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                name: 'Home',
                builder: (context, state) {
                  return MyHomePage(
                    key: state.pageKey,
                    title: 'Home Page',
                    imagePathsBanner: const ['images/home/Banner/Aanbieding1.png', 'images/home/Banner/SuperDeals.jpg'], // banner images
                    imagePathsPopular: const ['images/home/Popular/YodaFigure.jpg', 'images/home/Popular/BarbiePulsBeryDollSet.jpg'], // popular images
                    popularProductNames: const ["Yoda Figuur 1", "Barbie 2.0"], // product names
                    imagePathsRecommended: const ['images/home/Recommended/LegoDeathStar.jpg', 'images/home/Recommended/LegoDeathStar.jpg'], // recommended images
                    recommendedProductNames: const ['Lego Death Star', 'Lego Death Star'], // recommended product names
                    );
                },

                routes: [
                  GoRoute(
                    path: 'product/:name',
                    name: 'product',
                    builder: (context, state) {
                      return ProductPage(key: state.pageKey, name:state.pathParameters["name"]!);
                    },
                    ),
                ],
              ),
            ]),

          //Branch Search
          StatefulShellBranch(
            navigatorKey: _rootSearchKey,
            routes: [
              GoRoute(
                path: '/search',
                name: 'Search',
                builder: (context, state) {
                  return SearchPage(key: state.pageKey);
                },
              ),
            ]),

          //Branch Favorites
          StatefulShellBranch(
            navigatorKey: _rootFavoritesKey,
            routes: [
              GoRoute(
                path: '/favorites',
                name: 'Favorites',
                builder: (context, state) {
                  return FavoritePage(key: state.pageKey);
                },
              ),
            ]),

          //Branch Guide
          StatefulShellBranch(
            navigatorKey: _rootGuideKey,
            routes: [
              GoRoute(
                path: '/guide',
                name: 'guide',
                builder: (context, state) {
                  return WinkelGids(key: state.pageKey);
                },
              ),
            ]),

          //Branch QR
          StatefulShellBranch(
            navigatorKey: _rootQRKey,
            routes: [
              GoRoute(
                path: '/QR',
                name: 'QR',
                builder: (context, state) {
                  return QRPage(key: state.pageKey);
                },
              ),
            ]),
          ], 
        ),

    ],
  );  
}

