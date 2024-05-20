import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:group_9_app/pages/profile_choose.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> favoriteImages = [];
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final file = File('Account1.json');

    if (await file.exists()) {
      final content = await file.readAsString();
      final data = jsonDecode(content) as Map<String, dynamic>;

      final favorites = data['favorites'] as List<dynamic>;
      setState(() {
        favoriteImages = List<String>.from(favorites);
        selectedCategories = List<String>.from(data['favoriteCategories'] ?? []);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 159, 237),
        title: const Text('Profiel'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChooseInterestsPage(selectedInterests: selectedCategories),
                ),
              ).then((value) {
                if (value != null && value is List<String>) {
                  setState(() {
                    selectedCategories = value;
                  });
                  // Save the updated categories back to Account1.json
                  _saveUpdatedCategories();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle Settings action here
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Text('Geselecteerde Categorieën', style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 20),
            _buildSelectedCategories(),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const ChooseProfile(),
              ),
              (Route<dynamic> route) => false,
            );
          },
          child: const Icon(Icons.exit_to_app),
        ),
      ),
    );
  }

  Widget _buildSelectedCategories() {
    if (selectedCategories.isEmpty) {
      return const Text('Geen categorieën geselecteerd.');
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: selectedCategories.map((category) {
        return Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: Image.asset('images/categories/$category.png', fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Text(category),
          ],
        );
      }).toList(),
    );
  }

  Future<void> _saveUpdatedCategories() async {
    final file = File('Account1.json');

    if (await file.exists()) {
      final content = await file.readAsString();
      final data = jsonDecode(content) as Map<String, dynamic>;

      data['favoriteCategories'] = selectedCategories;

      await file.writeAsString(jsonEncode(data));
    }
  }
}

class ChooseInterestsPage extends StatefulWidget {
  final List<String> selectedInterests;

  const ChooseInterestsPage({Key? key, required this.selectedInterests}) : super(key: key);

  @override
  _ChooseInterestsPageState createState() => _ChooseInterestsPageState();
}

class _ChooseInterestsPageState extends State<ChooseInterestsPage> {
  late List<String> selectedInterests;

  @override
  void initState() {
    super.initState();
    selectedInterests = List.from(widget.selectedInterests);
  }

  // List of categories
  final List<String> categories = [
    'barbie',
    'DC',
    'disney',
    'lego',
    'pokemon',
    'spiderman',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent background
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background/blue background.jpg'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selecteer jouw interesses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              // List of categories
              SizedBox(
                height: 300, // Adjust the height as needed
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCategory(categories[0]),
                        _buildCategory(categories[1]),
                        _buildCategory(categories[2]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCategory(categories[3]),
                        _buildCategory(categories[4]),
                        _buildCategory(categories[5]),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Navigate back to the previous page
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: selectedInterests.isNotEmpty ? Colors.white : Colors.white.withOpacity(0.5), // Faded color for the arrow
                    ),
                    onPressed: selectedInterests.isNotEmpty
                        ? () {
                            // Pass the selected interests back to the previous page
                            Navigator.pop(context, selectedInterests);
                          }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String categoryName) {
    final isSelected = selectedInterests.contains(categoryName);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedInterests.remove(categoryName);
          } else {
            selectedInterests.add(categoryName);
          }
        });
      },
      child: CircleAvatar(
        radius: 43,
        backgroundColor: isSelected ? Colors.orange : Colors.transparent,
        child: Opacity(
          opacity: isSelected ? 0.5 : 1.0,
          child: CircleAvatar(
            radius: 38,
            backgroundImage: AssetImage('images/categories/$categoryName.png'),
          ),
        ),
      ),
    );
  }
}
