import 'package:flutter/material.dart';
import 'package:toy_hub_app/profile_picture.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isUsernameValid = false;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Kies jouw gebruikers naam',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _usernameController,
                onChanged: (value) {
                  setState(() {
                    _isUsernameValid = value.isNotEmpty;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Voer uw gebruikersnaam in',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 150), // Increased spacing between text field and arrows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: _isUsernameValid ? Colors.white : Colors.white.withOpacity(0.5)), // Faded color for the arrow
                  onPressed: _isUsernameValid
                      ? () {
                          // Navigate to next page or perform action
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChooseProfilePicturePage()),
                          );
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
