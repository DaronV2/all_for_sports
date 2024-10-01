import 'package:all_for_sports/Services/ConvertCode.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: Center(
        child: Column(
          children: const [
            ProductItem(
              supplierName: 'Decathlon', // Utiliser le nom du fournisseur ici
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
    );
  }
}

class ProductItem extends StatelessWidget {
  final String supplierName;
  final String reference;
  final String name;
  final int quantity;

  const ProductItem({
    super.key,
    required this.supplierName,
    required this.reference,
    required this.name,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    // Utiliser la méthode transform pour générer le code fournisseur à partir de la référence
    String supplierProductCode = ProductCodeTransformer.transform(supplierName);

    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage de la référence (code fournisseur transformé)
            Text('Référence produit : $supplierProductCode',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            // Affichage du nom (désignation du produit)
            Text('Désignation : $name'),
            // Affichage de la quantité en stock
            Text('Quantité en stock : $quantity'),
          ],
        ),
      ),
    );
  }
}
