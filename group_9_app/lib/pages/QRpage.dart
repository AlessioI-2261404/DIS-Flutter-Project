import 'package:flutter/material.dart';

class QRPage extends StatelessWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Page')),
      body: const Center(
        child: Text(
          'This is QR Page',
          style: TextStyle(fontSize: 24), // Adjust the font size as needed
        ),
      ),
    );
  }
}
