import 'dart:convert';
import 'dart:io';
import 'package:all_for_sports/services/FillProductList.dart';
import 'package:all_for_sports/services/Product.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final List<ProductItem> listeProd = [
    const ProductItem(
      reference: 'REF123',
      name: 'Produit 1',
      quantity: 10,
    ),
    const ProductItem(
      reference: 'REF456',
      name: 'Produit 2',
      quantity: 25,
    ),
    const ProductItem(
      reference: 'REF789',
      name: 'Produit 3',
      quantity: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: Center(
        child: Column(
          children: listeProd
          // ProductItem(
          //   reference: 'REF123',
          //   name: 'Produit 1',
          //   quantity: 10,
          // ),
          // ProductItem(
          //   reference: 'REF456',
          //   name: 'Produit 2',
          //   quantity: 25,
          // ),
          // ProductItem(
          //   reference: 'REF789',
          //   name: 'Produit 3',
          //   quantity: 5,
          // ),
          ,
        ),
      ),
    );
  }
}
