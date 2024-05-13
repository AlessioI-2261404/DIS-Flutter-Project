import 'package:flutter/material.dart';

class QRPage extends StatelessWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: QRScanPage(),
      ),
    );
  }
}

class QRScanPage extends StatelessWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Scan uw QR-code hier',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        _buildQRCode(),
      ],
    );
  }

  Widget _buildQRCode() {
    return Image(
      image: const NetworkImage('https://upload.wikimedia.org/wikipedia/commons/2/2f/Rickrolling_QR_code.png'),
      width: 200,
      height: 200,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const CircularProgressIndicator();
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    );
  }
}