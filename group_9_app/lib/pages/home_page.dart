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
  int currentImg = 0;

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
                            color: isSelected? Color.fromARGB(141, 202, 202, 243): Color.fromARGB(153, 0, 0, 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          
                          duration: const Duration(milliseconds: 400),
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
                  Row(
                    
                  ),
                ],
              ),
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