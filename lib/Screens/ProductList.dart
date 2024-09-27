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
        child: const Column(
          children: [
            ProductItem(
              reference: 'REF123',
              name: 'Produit 1',
              quantity: 10,
            ),
            ProductItem(
              reference: 'REF456',
              name: 'Produit 2',
              quantity: 25,
            ),
            ProductItem(
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
  final String reference;
  final String name;
  final int quantity;

  const ProductItem({
    super.key,
    required this.reference,
    required this.name,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Référence : $reference',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Nom : $name'),
            Text('Quantité en stock : $quantity'),
          ],
        ),
      ),
    );
  }
}
