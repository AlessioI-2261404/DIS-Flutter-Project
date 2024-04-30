import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  void foo() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            //Superdeals
            CarouselSlider(
              items: HomePageData.imagePathsBanner.map((imgPath) { 
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(195, 255, 193, 7),
                    borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(imgPath, fit: BoxFit.fill),
              ); }).toList(),
              options: CarouselOptions(
                height: 250,
                )),

            //The page with the recommended products
            Row(
              children: [
                TextButton(onPressed: foo, child: const Text('hallo')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.