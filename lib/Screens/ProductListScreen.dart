import 'package:flutter/material.dart';
import 'package:all_for_sports/Screens/FlashQRCodeScreen.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: Stack(
        children: [
          // Liste des produits affichée au centre
          const Center(
            child: Column(
              children: [
                ProductItem(
                  supplierName: 'Decathlon',
                  reference: 'REF123',
                  name: 'Produit 1',
                  quantity: 10,
                ),
                ProductItem(
                  supplierName: 'Nike',
                  reference: 'REF456',
                  name: 'Produit 2',
                  quantity: 25,
                ),
                ProductItem(
                  supplierName: 'Adidas',
                  reference: 'REF789',
                  name: 'Produit 3',
                  quantity: 5,
                ),
              ],
            ),
          ),
          // Bouton "+" en bas à droite
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                // Ouvrir la page de scan QR code
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const FlashQRCodeScreen(),
                ));
              },
              child: const Icon(Icons.add, size: 40),
              backgroundColor: Colors.blue,
              tooltip: 'Scanner un produit',
            ),
          ),
        ],
      ),
    );
  }
}
