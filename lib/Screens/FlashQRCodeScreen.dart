import 'package:flutter/material.dart';

class PageQRCode extends StatelessWidget {
  const PageQRCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Center(
        child: const Text(
          'Bienvenue sur la Page QRCode!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
