import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key, required this.product});
  final String product;

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  File ? _selected;
  bool choosen = false;

  void _navigateBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Future _pickFileFormGallary() async {
    final returnFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnFile == null) return;
    setState(() {
      choosen = true;
      _selected = File(returnFile.path);
    });
  }

  // String getFileName(String path){
  //   path.
  // }

  void _uploadStory() async {
    if (_selected == null) { return; }

    final file = File('Product.json');
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

    Map<String, dynamic> productData = {};
    //search for product
    data.forEach((key, value) { if (key == widget.product) {
      productData[key] = value;
    }});

    dynamic test = productData[widget.product];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 159, 237),
        title: const Text('Voeg verhaal toe'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/home/Background.png"),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _selected != null ? Image.file(_selected!) : const Text("Kies een afbeelding"),
              const SizedBox(height: 20,),
              choosen? Row(children: [
                  const SizedBox(width: 40,),
                  IconButton(onPressed: () => _pickFileFormGallary(),
                  icon: const Icon(Icons.redo)),
                  const SizedBox(width: 140,),
                  IconButton(onPressed: () => _uploadStory(), icon: const Icon(Icons.navigate_next))
              ],)
              : TextButton(
                onPressed: () => _pickFileFormGallary(), 
                child: const Text('kies foto')
              ), 
            ]
          ),
        )
      )
    );
  }
}