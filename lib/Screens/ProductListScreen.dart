import 'package:all_for_sports/Screens/AddProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final List<ProductItem> listeProd = [
    // const ProductItem(
    //   reference: 'REF123',
    //   name: 'Produit 1',
    //   quantity: 10,
    // ),
    // const ProductItem(
    //   reference: 'REF456',
    //   name: 'Produit 2',
    //   quantity: 25,
    // ),
    // const ProductItem(
    //   reference: 'REF789',
    //   name: 'Produit 3',
    //   quantity: 5,
    // ),
  ];

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
                  supplierName:
                      'Decathlon', // Utiliser le nom du fournisseur ici
                  reference: 'REF123',
                  name: 'Produit 1',
                  quantity: 10,
                ),
                ProductItem(
                  supplierName: 'Nike', // Un autre exemple de fournisseur
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
                // Ouvrir l'écran d'ajout de produit
                Navigator.of(context).push(MaterialPageRoute(
                  builder: ((BuildContext context) => const AddProductScreen()),
                ));
              },
              child: const Icon(Icons.add,
                  size: 40), // Taille de l'icône plus grande
              backgroundColor: Colors.blue,
              tooltip: 'Ajouter un produit',
            ),
          ),
        ],
      ),
    );
  }
}
