import 'package:flutter/material.dart';
import 'FlashQRCodeScreen.dart';
import 'ProductListScreen.dart';

class AccDart extends StatelessWidget {
  const AccDart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page d\'Accueil - AccDart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigation vers la Page Ajouter Produit
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              },
              child: const Text('Aller à la Liste des Produits'),
            ),
            const SizedBox(height: 20), // Espacement entre les boutons
            ElevatedButton(
              onPressed: () {
                // Navigation vers la Page Liste Produit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FlashQRCodeScreen()),
                );
              },
              child: const Text('Aller à la PageQRCode'),
            ),
          ],
        ),
      ),
    );
  }
}
