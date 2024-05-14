import 'package:flutter/material.dart';

class WinkelgidsMock extends StatefulWidget {
  const WinkelgidsMock({Key? key}) : super(key: key);

  @override
  _WinkelgidsMockState createState() => _WinkelgidsMockState();
}

class _WinkelgidsMockState extends State<WinkelgidsMock> {
  int _currentIndex = 0;
  final List<String> _images = [
    'images/winkelgids/1.png',
    'images/winkelgids/2.png',
    'images/winkelgids/3.png',
    'images/winkelgids/4.png',
    'images/winkelgids/5.png',
    'images/winkelgids/6.png',
    'images/winkelgids/7.png',
  ];

  void _nextImage() {
    if (_currentIndex < _images.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: const Icon(Icons.close, size: 40, color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mocked AR functionality',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.volume_up, size: 30, color: Colors.black),
                  ],
                ),
                const SizedBox(height: 25),
                Image.asset(
                  _images[_currentIndex],
                  fit: BoxFit.contain,
                  width: 375, 
                  height: 375,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 50,
                        color: _currentIndex > 0 ? Colors.black : Colors.grey,
                      ),
                      onPressed: _currentIndex > 0 ? _previousImage : null,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 50,
                        color: _currentIndex < _images.length - 1 ? Colors.black : Colors.grey,
                      ),
                      onPressed: _currentIndex < _images.length - 1 ? _nextImage : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
