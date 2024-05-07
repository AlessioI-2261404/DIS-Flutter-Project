import 'package:flutter/material.dart';

class WinkelGids extends StatelessWidget {
  const WinkelGids({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WinkelGids')),
      body: const Center(
        child: Text(
          'This is the WinkelGids',
          style: TextStyle(fontSize: 24), // Adjust the font size as needed
        ),
      ),
    );
  }
}
