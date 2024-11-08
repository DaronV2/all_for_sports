import 'dart:convert';
import 'package:all_for_sports/Screens/WelcomeScreen.dart';
import 'package:all_for_sports/Services/Produit.dart';
import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Services/Api.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late String refProduit;
  late int quantite;
  // Contrôleurs pour les TextField

  final TextEditingController quantiteController =
      TextEditingController(); // Controller Du TextField qui va recevoir la quantité

  final TextEditingController _controllerRefProduct =
      TextEditingController(text: WareHouseProvider.getRefProduct().toString());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text('Vous êtes en mode déconnecté !'),
          duration: Duration(days: 1), // Durée d'affichage du SnackBar
          dismissDirection: DismissDirection.none,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Récupération de l'entrepôt grâce au provider
    String entrepot = Provider.of<WareHouseProvider>(context).entrepot;
    String refProduit = Provider.of<WareHouseProvider>(context).refProduit;
    bool textFieldEnabled = true;
    print(_controllerRefProduct.text.toString());
    if (_controllerRefProduct.text.toString() != '') {
      textFieldEnabled = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un produit'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Affichage de la référence du produit (non modifiable)
            const Text(
              'Référence du produit:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controllerRefProduct,
              enabled: textFieldEnabled,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
                // Créer un Map pour le JSON
                Produit Ballon = Produit(refProduit, entrepot, quantite);
                String JasonBallon = jsonEncode(Ballon.toJson());
                print("JSon : "+ JasonBallon);

                //Appele de méthode pour envoyer le produit à l'API, et stokage de la valeur dans la variable Réponse de l'API
                String reponseDeAPI = Api.extractProductReference(JasonBallon);

                Provider.of<WareHouseProvider>(context, listen: false)
                    .setRefProduit('');

                // Affichage d'une SnackBar avec la réponse de l'API
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(reponseDeAPI),
                    duration: const Duration(
                        seconds: 5), // Durée d'affichage de la SnackBar
                  ),
                );
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const WelcomeScreen()));
              },
              child: const Text('Ajouter le produit'),
            ),
          ],
        ),
      ),
    );
  }
}
