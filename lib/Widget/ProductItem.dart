import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String reference;
  final String name;
  final int quantity;
  final String addingDate;

  const ProductItem({
    required this.reference,
    required this.name,
    required this.quantity,
    required this.addingDate
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
