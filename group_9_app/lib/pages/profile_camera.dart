import 'package:flutter/material.dart';
import 'package:group_9_app/pages/profile_location.dart';

class CameraAccessPage extends StatefulWidget {
  const CameraAccessPage({Key? key}) : super(key: key);

  @override
  _CameraAccessPageState createState() => _CameraAccessPageState();
}

class _CameraAccessPageState extends State<CameraAccessPage> {
  bool? _cameraAccessGranted;

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
                  'Geef je toegang tot jouw camera?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'images/authorization/camera.png',
                height: 200,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _cameraAccessGranted = true;
                      });
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Ja'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _cameraAccessGranted == true
                          ? Colors.green // Highlight the selected option
                          : null,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _cameraAccessGranted = false;
                      });
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Nee'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _cameraAccessGranted == false
                          ? Colors.red // Highlight the selected option
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
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
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: _cameraAccessGranted == null
                          ? Colors.white.withOpacity(0.5) // Fade the arrow when no option is selected
                          : Colors.white,
                    ),
                    onPressed: _cameraAccessGranted != null
                        ? () {
                            // Navigate to the next page
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LocationAccessPage()),
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
}