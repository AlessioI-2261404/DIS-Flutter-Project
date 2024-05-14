import 'package:flutter/material.dart';
import 'package:group_9_app/pages/profile_categories.dart';

class ChooseProfilePicturePage extends StatefulWidget {
  const ChooseProfilePicturePage({Key? key}) : super(key: key);

  @override
  _ChooseProfilePicturePageState createState() => _ChooseProfilePicturePageState();
}

class _ChooseProfilePicturePageState extends State<ChooseProfilePicturePage> {
  String? selectedPicture;

  // List of profile pictures
  final List<String> profilePictures = [
    'annakin.png',
    'barbie.png',
    'dora.png',
    'paw patrol.png',
    'stich.png',
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
                'Kies uw profielfoto',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              // List of profile pictures
              SizedBox(
                height: 150, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: profilePictures.length,
                  itemBuilder: (context, index) {
                    final pictureName = profilePictures[index];
                    return _buildProfilePicture(pictureName);
                  },
                ),
              ),
              const SizedBox(height: 150),
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
                      color: selectedPicture != null ? Colors.white : Colors.white.withOpacity(0.5), // Faded color for the arrow
                    ),
                    onPressed: selectedPicture != null
                        ? () {
                            // Navigate to the next page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ChooseInterestsPage()),
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

  Widget _buildProfilePicture(String pictureName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPicture = pictureName;
        });
      },
      child: CircleAvatar(
        radius: 53,
        backgroundColor: selectedPicture == pictureName ? Colors.orange : Colors.transparent,
        child: CircleAvatar(
          radius: 48,
          backgroundImage: AssetImage('images/profile_pictures/$pictureName'),
        ),
      ),
    );
  }
}