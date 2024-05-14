import 'package:flutter/material.dart';
import 'package:group_9_app/pages/profile_categories.dart';

class ChooseProfilePicturePage extends StatefulWidget {
  const ChooseProfilePicturePage({Key? key}) : super(key: key);

  @override
  _ChooseProfilePicturePageState createState() =>
      _ChooseProfilePicturePageState();
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
                height: 300, // Adjust the height as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildProfilePicture(profilePictures[0]),
                        SizedBox(width: 10),
                        _buildProfilePicture(profilePictures[1]),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildProfilePicture(profilePictures[2]),
                        SizedBox(width: 10),
                        _buildProfilePicture(profilePictures[3]),
                      ],
                    ),
                    SizedBox(height: 10),
                    _buildProfilePicture(profilePictures[4]),
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
                      color: selectedPicture != null
                          ? Colors.white
                          : Colors.white.withOpacity(0.5), // Faded color for the arrow
                    ),
                    onPressed: selectedPicture != null
                        ? () {
                            // Navigate to the next page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChooseInterestsPage()),
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
        radius: 40,
        backgroundColor:
            selectedPicture == pictureName ? Colors.orange : Colors.transparent,
        child: CircleAvatar(
          radius: 35,
          backgroundImage:
              AssetImage('images/profile_pictures/$pictureName'),
        ),
      ),
    );
  }
}