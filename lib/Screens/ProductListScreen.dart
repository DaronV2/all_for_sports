import 'package:all_for_sports/Screens/AddProductScreen.dart';
import 'package:all_for_sports/Services/FillProductList.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Screens/FlashQRCodeScreen.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

class _ProductListScreen extends State<ProductListScreen> {
  List<ProductItem> listeProd = [];

  @override
  void initState() {
    super.initState();
    loadList();
  }

  Future<void> loadList() async {
    listeProd = await FillProductList.loadProductList();
    print("los datas ");
    listeProd.forEach((data) {
      print(data);
    });
    setState(() {});
  }

  //TODO changer la column afin de la rendre flexible avec barre de scroll

  Future<void> loadProducts() async {
    await FillProductList.loadProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
      ),
      body: Center(
        child: Stack(children: [
          Column(
            children: listeProd,
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                // Ouvrir l'écran d'ajout de produit
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const AddProduct(),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                size: 40, // Taille de l'icône plus grande
              ),
              backgroundColor: Colors.blue,
              tooltip: 'Scanner un produit',
            ),
          ),
        ]),
      ),
    );
  }
}
