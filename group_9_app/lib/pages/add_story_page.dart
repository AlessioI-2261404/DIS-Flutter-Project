import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key, required this.product, required this.refresh});
  final String product;
  final VoidCallback refresh;
  
  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  File ? _selected;
  bool choosen = false;
  var uuid = const Uuid();

  Future _pickFileFormGallary() async {
    final returnFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnFile == null) return;
    setState(() {
      choosen = true;
      _selected = File(returnFile.path);
    });
  }

  void _return(BuildContext context) {
    Navigator.pop(context);
  }

  void _uploadStory(BuildContext context) async {
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

    final String fileName = uuid.v1() + '.png';  //generate name based on time
    final String savedPath = join("images/stories/", fileName);

    //copy the selected image to the specified path
    await File(_selected!.path).copy(savedPath);
    _modifyJsonFile(savedPath);
    widget.refresh(); //Call refresh
    _return(context);
  }

  Future<void> _modifyJsonFile(String path) async {
    // Read the JSON file
    final File file = File('Product.json');
    if (!file.existsSync()) {
      if (kDebugMode) { print("File not found"); }
      return;
    }
    final String contents = await file.readAsString();
    final List<dynamic> jsonData = jsonDecode(contents);

    // Find the product and update its stories
    for (var product in jsonData) {
      if (product['name'] == widget.product) {
        product['stories'].add({
          'type': 'IMG',
          'header': path,
          'file': path,
        });
        break;
      }
    }

    // Write the updated JSON back to the file
    await file.writeAsString(jsonEncode(jsonData));
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
                  IconButton(onPressed: () => _uploadStory(context), icon: const Icon(Icons.navigate_next))
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