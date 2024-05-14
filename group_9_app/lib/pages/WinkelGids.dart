import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:group_9_app/pages/WinkelgidsMock.dart';  

class WinkelGids extends StatefulWidget {
  const WinkelGids({Key? key}) : super(key: key);

  @override
  _WinkelGidsState createState() => _WinkelGidsState();
}

class _WinkelGidsState extends State<WinkelGids> {
  bool? locationAccess;
  List<dynamic>? favorites;
  String message = 'Loading...';
  int? _selectedItemIndex;

  @override
  void initState() {
    super.initState();
    checkInitialAccess();
  }

  Future<void> checkInitialAccess() async {
    final file = File('Account1.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      locationAccess = jsonData['accountDetails']['locationAccess'] as bool;
      favorites = jsonData['favorites'] as List<dynamic>;

      setState(() {
        if (!locationAccess!) {
          message = "Om deze functie te gebruiken, is uw locatie vereist. Wilt u deze met ons delen?";
        } else if (favorites!.isEmpty) {
          message = "Je hebt niks geliked, er wacht nog veel te ontdekken voor u";
        }
      });
    } else {
      setState(() {
        message = "Failed to load data!";
      });
    }
  }

  Future<void> updateLocationAccess() async {
    final file = File('Account1.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      jsonData['accountDetails']['locationAccess'] = true;
      await file.writeAsString(jsonEncode(jsonData));
      setState(() {
        locationAccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 159, 237),
        title: const Text('WinkelGids'),
      ),
      body: Center(
        child: locationAccess == null
            ? const CircularProgressIndicator()
            : locationAccess! && (favorites == null || favorites!.isEmpty)
              ? Center(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              : buildFavoritesGrid(),
      ),
      floatingActionButton: _selectedItemIndex != null ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WinkelgidsMock()));
        },
        label: Text("Vind Item"),
        icon: Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue,
      ) : null,
    );
  }

  Widget buildFavoritesGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.2,
      ),
      itemCount: favorites!.length,
      itemBuilder: (context, index) {
        final item = favorites![index];
        bool isSelected = _selectedItemIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              if (_selectedItemIndex == index) {
                _selectedItemIndex = null; // Deselect if already selected
              } else {
                _selectedItemIndex = index; // Select new item
              }
            });
          },
          child: Card(
            color: isSelected ? Colors.blue[100] : Colors.white,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    item['imagePath'],
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  title: Text(item['title']),
                  tileColor: isSelected ? Colors.blue[50] : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
