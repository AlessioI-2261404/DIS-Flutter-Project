import 'package:flutter/material.dart';
import 'package:group_9_app/pages/profile_name.dart';

void main() {
  runApp(const ProfileChoose());
}

class ProfileChoose extends StatelessWidget {
  const ProfileChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 63, 148, 223)),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background/blue background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Kies uw account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  size: 100,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigate to create profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}