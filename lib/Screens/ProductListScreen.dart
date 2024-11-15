import 'package:all_for_sports/Screens/FlashQRCodeScreen.dart';
import 'package:all_for_sports/Services/FillProductList.dart';
import 'package:all_for_sports/Services/LoadingSceen.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

class _ProductListScreen extends State<ProductListScreen> {
  // Liste des widgets ProductItem qui stockera les widgets et permettra de les afficher
  List<ProductItem> productList = [];

  bool isScreenLoading = true; //Cette variable permettra d'afficher ou non un écran de chargement, true = affiche l'écran de chargement 
  bool backArrow = false; // variable pour enlever la fleche de retour a la précédente page

  // Fonction Flutter qui se lance au chargement de la page
  @override
  void initState() {
    super.initState();
    loadList();
  }

  // Fonction qui permet de remplir la liste de Widgets et de recharger l'état de la page
  Future<void> loadList() async {
    productList = await FillProductList.loadProductList();
    isScreenLoading = false;
    backArrow = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
        automaticallyImplyLeading: backArrow, // Permet d'afficher ou non la fleche de retour a la page précédente
      ),
      body: Center(
        child: isScreenLoading
            ? const LoadingScreen()
            : Stack(
                children: [
                  // Utilisation de ListView.builder pour le défilement infini
                  ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return productList[index]; // Affiche chaque produit
                    },
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Ouvrir l'écran d'ajout de produit
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const FlashQRCodeScreen(),
                          ),
                        );
                      },
                      backgroundColor: Colors.blue,
                      tooltip: 'Ajouter un produit',
                      child: const Icon(
                        Icons.add,
                        size: 40, // Taille de l'icône plus grande
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
