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

  void _ARbtn(){
    //todo
  }

  void _compareBtn(){
    //todo
  }

  void _favoritesBtn(){
    //todo
  }

  List<Widget> _buildIndexImages() {
    List<Widget> array = [];
    for (int i = 0; i < 4; i++){
      array.add(
        SizedBox(
          width: 80,
          height: 80,
          child: Image.asset('images/home/LegoDeathStar.jpg', fit: BoxFit.fill, opacity: const AlwaysStoppedAnimation(0.6),),
        )
      );
    }
    return array;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/home/Background.png"), //Change to the background theme of said product
            fit: BoxFit.cover
            )),
        child: Center(
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

              const SizedBox(height: 10),
        
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //Preview image
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            SizedBox(
                              width: 360,
                              height: 280,
                              child: Image.asset('images/home/LegoDeathStar.jpg', fit: BoxFit.fill,),  //Change to product image later (dynamically)
                            ),
                  
                            const Positioned( //const temp
                              top: 0.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.grade, size: 30, color: Colors.yellow,),
                                    Icon(Icons.grade, size: 30, color: Colors.yellow,),
                                    Icon(Icons.grade_outlined, size: 30,),
                                    Icon(Icons.grade_outlined, size: 30,),
                                    Icon(Icons.grade_outlined, size: 30,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  
                        //Image indicators
                        SizedBox(
                          width: 350,
                          height: 80,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => const SizedBox(width: 10),
                            itemCount: 5,
                            itemBuilder: ((context, index) {
                              return SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.asset('images/home/LegoDeathStar.jpg', fit: BoxFit.fill, opacity: const AlwaysStoppedAnimation(0.6),),
                              );
                            }),
                          ),
                        ),
                  
                        const SizedBox(height: 25),
                  
                        //info + iconButtons
                        Row(
                          children: [
                            const SizedBox(width: 40),
                            const Icon(Icons.attach_money, size: 23),
                            const Text("5.99", style: TextStyle(fontSize: 20),),
                            const SizedBox(width: 105),
                            IconButton(onPressed: _ARbtn, icon: const Icon(Icons.view_in_ar, size: 45)),
                            IconButton(onPressed: _compareBtn, icon: const Icon(Icons.balance, size: 45)),
                            IconButton(onPressed: _favoritesBtn, icon: const Icon(Icons.favorite_border, size: 45)),
                          ],
                        ),
                  
                        //Beschrijving
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: ExpansionTile(
                            title: Text("Beschrijving"),
                            subtitle: Text("Hallo dit is een test om ..."),
                            children: [
                              Text("Hallo dit is een test als het ook lukt om gewonen text hierin te plaatsen. Zonder de nood van ListTile!"),
                            ],
                          ),
                          ),
                  
                        const SizedBox(height: 15),
                  
                        const Text("Vergelijkbare Producten", style: TextStyle(fontSize: 20),),
                        const Row(
                          children: [

                          ],
                        ),

                        const SizedBox(height: 30),

                        const 
                        //view user stories
                      ],
                    ),
                  ),
                ),
              ),
        
            ],
          ),
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