import 'package:flutter/material.dart';
import 'package:toy_hub_app/profile_parent.dart';

class ChooseInterestsPage extends StatefulWidget {
  const ChooseInterestsPage({Key? key}) : super(key: key);

  @override
  _ChooseInterestsPageState createState() => _ChooseInterestsPageState();
}

class _ChooseInterestsPageState extends State<ChooseInterestsPage> {
  List<String> selectedInterests = [];

  // List of categories
  final List<String> categories = [
    'barbie.png',
    'DC.png',
    'disney.png',
    'lego.png',
    'pokemon.png',
    'spiderman.png',
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
                            // Navigate to the next page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ParentAuthorizationPage()),
                            );
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
        child: CircleAvatar(
          radius: 38,
          backgroundImage: AssetImage('images/categories/$categoryName'),
        ),
      ),
    );
  }
}
