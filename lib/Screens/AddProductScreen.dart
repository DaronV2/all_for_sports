import 'dart:convert';
import 'package:all_for_sports/Services/Produit.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:all_for_sports/Services/Api.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late String refProduit;
  String entrepot =
      'Lyon'; // Valeur déjà sur Lyon reçue de Géolocalisation si fonctionnelle
  late int quantite;
  // Contrôleurs pour les TextField
  final TextEditingController refProduitController =
      TextEditingController(); // Controller Du TextField qui va recevoir la refProduit
  final TextEditingController quantiteController =
      TextEditingController(); // Controller Du TextField qui va recevoir la quantité

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un produit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Champ de texte pour la référence du produit
            TextField(
              controller: refProduitController,
              decoration: const InputDecoration(
                labelText: 'Référence du produit',
              ),
              onChanged: (value) {
                refProduit = value;
              },
            ),
            // Affichage de l'entrepôt sans champ de texte modifiable
            const SizedBox(height: 20),
            Text(
              'Entrepôt: $entrepot',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Champ de texte pour la quantité
            TextField(
              controller: quantiteController,
              decoration: const InputDecoration(
                labelText: 'Quantité',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                quantite = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Action à effectuer lors de la soumission du formulaire
                print('Référence du produit: $refProduit');
                print('Entrepôt: $entrepot');
                print('Quantité: $quantite');

                // Créer un Map pour le JSON
                Produit Ballon = Produit(refProduit, entrepot, quantite);
                String JasonBallon = jsonEncode(Ballon.toJson());
                print(JasonBallon);

                //Appele de méthode pour envoyer le produit à l'API, et stokage de la valeur dans la variable Réponse de l'API
                String reponseDeAPI = await Api.sendProductToApi(JasonBallon);

                // Affichage d'une SnackBar avec la réponse de l'API
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(reponseDeAPI),
                    duration: const Duration(
                        seconds: 5), // Durée d'affichage de la SnackBar
                  ),
                );
              },
              child: const Text('Ajouter le produit'),
            ),
          ],
        ),
      ),
    );
  }
}
