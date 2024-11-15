import 'package:all_for_sports/Screens/FlashQRCodeScreen.dart';
import 'package:all_for_sports/Services/FillProductList.dart';
import 'package:all_for_sports/Services/LoadingSceen.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';

/// Classe `ProductListScreen`
///
/// Ce widget représente l'écran affichant une liste de produits.
/// L'utilisateur peut visualiser une liste de produits récupérés depuis une source de données
/// et ajouter un nouveau produit en scannant un QR code.
class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

/// Classe `_ProductListScreen`
///
/// Gère l'état de l'écran de liste des produits.
/// Contient la logique pour charger les produits et gérer les interactions utilisateur.
class _ProductListScreen extends State<ProductListScreen> {
  /// Liste des widgets `ProductItem` qui représente les produits.
  List<ProductItem> productList = [];

  /// Variable pour afficher ou non l'écran de chargement (true = affiche le chargement).
  bool isScreenLoading = true;

  /// Variable pour afficher ou non la flèche de retour dans la barre d'application.
  bool backArrow = false;

  /// Méthode `initState` :
  /// Appelée lors de l'initialisation de la page.
  /// Charge la liste des produits en appelant la fonction `loadList`.
  @override
  void initState() {
    super.initState();
    loadList(); // Chargement de la liste des produits.
  }

  /// Méthode `loadList` :
  ///
  /// Charge les produits via le service `FillProductList`.
  /// Une fois les produits récupérés, met à jour l'état de la page pour les afficher.
  Future<void> loadList() async {
    productList = await FillProductList.loadProductList();
    isScreenLoading = false;
    backArrow = true;
    setState(() {}); // Met à jour l'interface utilisateur.
  }

  /// Méthode `build` :
  ///
  /// Construit l'interface utilisateur de la liste des produits.
  /// Affiche une liste déroulante des produits ou un écran de chargement si les données ne sont pas encore prêtes.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Titre de la page et gestion de la flèche de retour.
        title: const Text('Liste des produits'),
        automaticallyImplyLeading: backArrow, // Affiche ou non la flèche.
      ),
      body: Center(
        child: isScreenLoading
            ? const LoadingScreen() // Affiche un écran de chargement si les données sont en cours de traitement.
            : Stack(
                children: [
                  // Liste des produits affichée avec un défilement infini.
                  ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return productList[index]; // Affiche chaque produit.
                    },
                  ),
                  // Bouton flottant pour ajouter un nouveau produit.
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Ouvre l'écran pour scanner un QR code.
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
                        size: 40, // Taille de l'icône.
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
