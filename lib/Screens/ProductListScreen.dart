import 'package:all_for_sports/Services/FillProductList.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreen();

}

class _ProductListScreen extends State<ProductListScreen>{

  List<ProductItem> listeProd = [];

  @override
  void initState() {
    super.initState();
    loadList();
  }

  Future<void> loadList() async {
    listeProd = await FillProductList.loadProductList();
    print("los datas ");
    listeProd.forEach((data){
      print(data);
    });
    setState(() {
      
    });
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
        child: Column(
          children: 
          listeProd,
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
        ),
      ),
    );
  }
}
