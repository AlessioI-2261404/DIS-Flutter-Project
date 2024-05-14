import 'package:flutter/material.dart';
import 'package:toy_hub_app/profile_camera.dart';

class ParentAuthorizationPage extends StatelessWidget {
  const ParentAuthorizationPage({Key? key}) : super(key: key);

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
              const Center(
                child: Text(
                  'Kan je een ouder erbij halen voor de volgende stappen?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'images/authorization/parent_help.png',
                height: 200,
              ),
              const SizedBox(height: 80),
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
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Navigate to the next page
                      Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CameraAccessPage()),
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
