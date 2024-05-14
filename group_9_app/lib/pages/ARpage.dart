import 'package:flutter/material.dart';

class ARPage extends StatelessWidget {
  const ARPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const Center(
            child: Text(
              "AR Content Here", // Placeholder for your AR content
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30, color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}