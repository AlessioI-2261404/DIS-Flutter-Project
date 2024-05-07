import 'package:flutter/material.dart';
import 'package:group_9_app/datastructures/navigation_bar.dart';

class ProductPage extends StatefulWidget{
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  void _returnBtn() {
    //todo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Product name"),
      //   actions: <Widget> [
      //           IconButton(onPressed: _returnBtn, icon: const Icon(Icons.keyboard_return), iconSize: 40),
      //           IconButton(onPressed: _returnBtn, icon: const Icon(Icons.share), iconSize: 40),
      // ]),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: _returnBtn, icon: const Icon(Icons.keyboard_return), iconSize: 40),
                const SizedBox(width: 45),
                const Text("<Product name>", textAlign: TextAlign.center, style: TextStyle(fontSize: 25)),
                const SizedBox(width: 45),
                IconButton(onPressed: _returnBtn, icon: const Icon(Icons.share), iconSize: 40),
              ],
            ),

            SingleChildScrollView(
              child: Column(
                
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[ 
          BottemNavigation(),
          ],
      ),
    );
  }
}