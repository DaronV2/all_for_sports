import 'package:all_for_sports/Services/FillProductList.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';

/// Classe `ProductListScreen`
///
/// Ce widget représente l'écran affichant une liste de produits.
/// Il utilise une source de données pour charger les informations des produits.
class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

/// Classe `_ProductListScreen`
///
/// Cette classe gère l'état de l'écran de liste des produits.
/// Elle contient la logique pour charger les données des produits et les afficher dans une liste.
class _ProductListScreen extends State<ProductListScreen> {
  // Liste pour stocker les widgets `ProductItem` représentant chaque produit
  List<ProductItem> listeProd = [];

  /// Méthode `initState` :
  ///
  /// Cette méthode est appelée automatiquement lors de l'initialisation de l'état du widget.
  /// Elle initialise la liste des produits en appelant `loadList`.
  @override
  void initState() {
    super.initState();
    loadList(); // Appel de la fonction pour charger la liste de produits
  }

  /// Méthode `loadList` :
  ///
  /// Cette méthode charge les données des produits en appelant une méthode asynchrone
  /// `FillProductList.loadProductList()`. Elle met à jour l'interface une fois les données chargées.
  ///
  /// Retourne :
  /// - Un `Future<void>`, car la méthode est asynchrone.
  Future<void> loadList() async {
    // Charge la liste des produits et l'assigne à `listeProd`
    listeProd = await FillProductList.loadProductList();
    print("los datas "); // Message de vérification dans la console

    // Affiche chaque produit dans la console pour vérification
    listeProd.forEach((data) {
      print(data);
    });

    // Rafraîchit l'interface pour afficher les nouveaux produits chargés
    setState(() {});
  }

  /// Méthode `build` :
  ///
  /// Cette méthode construit l'interface utilisateur, qui contient une liste de produits.
  ///
  /// Paramètre :
  /// - `context`: le contexte de construction du widget.
  ///
  /// Retourne :
  /// - Un widget `Scaffold` contenant l'interface de la liste des produits.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Titre dans la barre supérieure
        title: const Text('Liste des produits'),
      ),
      body: Center(
        child: Stack(
          children: [
            // Utilisation de ListView.builder pour afficher et défiler la liste des produits
            ListView.builder(
              itemCount: listeProd.length, // Nombre d'éléments dans la liste
              itemBuilder: (context, index) {
                // Retourne chaque widget `ProductItem` de la liste
                return listeProd[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}
