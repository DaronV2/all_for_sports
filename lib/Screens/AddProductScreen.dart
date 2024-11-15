import 'dart:convert';
import 'package:all_for_sports/Screens/WelcomeScreen.dart';
import 'package:all_for_sports/Services/ConnexionProvider.dart';
import 'package:all_for_sports/Services/ProductListProvider.dart';
import 'package:all_for_sports/Services/ProductReferenceProvider.dart';
import 'package:all_for_sports/Services/Produit.dart';
import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:flutter/material.dart';
import 'package:all_for_sports/Services/Api.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late String productReference; // Référence du produit scanné par un QR Code
  late int quantity; // Quantité de Produit à ajouté 

  // Contrôleurs pour les TextField
  final TextEditingController _controllerQuantity = TextEditingController(); // Controller Du TextField qui va recevoir la quantité

  final TextEditingController _controllerProductReference = TextEditingController(text: ProductReferenceProvider.getRefProduct().toString()); // Controller Du TextField qui va recevoir la refProduit

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String warehouseString = Provider.of<WareHouseProvider>(context).entrepot; // Récupération de l'entrepôt grâce au provider
    String productReferenceString = Provider.of<ProductReferenceProvider>(context).refProduit; // Récupération de la référence du produit scanné par le QR code grâce au provider
    bool productReferenceEnabled = false; // Variable qui grise le textfield Du productReference
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
              controller: _controllerProductReference,
              enabled: productReferenceEnabled,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Affichage de l'entrepôt sans champ de texte modifiable
            const SizedBox(height: 20),
            Text(
              'Entrepôt: $warehouseString',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Champ de texte pour la quantité
            TextField(
              controller: _controllerQuantity,
              decoration: const InputDecoration(
                labelText: 'Quantité',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                quantity = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Action à effectuer lors de la soumission du formulaire
                Produit objectProduct = Produit(productReferenceString, warehouseString, quantity); // Création de l'objet produit avec les valeurs entrées 
                String jsonProduct = jsonEncode(objectProduct.toJson()); // Serialisation de l'objet produit en JSON 

                String apiResponse = Api.extractProductReference(jsonProduct); //Appel de méthode pour envoyer le produit à l'API, et stokage de la valeur dans la variable Réponse de l'API

                Provider.of<ProductReferenceProvider>(context, listen: false).setRefProduit(''); // Mettre la référence produit à nul après son envoi a l'API

                // Affichage d'une SnackBar avec la réponse de l'API
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(apiResponse),
                    duration: const Duration(
                        seconds: 5), // Durée d'affichage de la SnackBar
                  ),
                );

                bool connexion = Provider.of<ConnexionProvider>(context, listen: false).connexion; // Variable qui récupère si l'application est connéctée a internet ou non 
                if(connexion){
                  Api.send(RequeteType.post, jsonProduct); // Envoi de la requete pour ajouté le produit a l'api 
                  List<String> waitingRequestList = Provider.of<ProductListProvider>(context, listen: false).listRequete; // Récupération de la liste de requetes qui ont étées ajoutées a la liste si il n'y a pas eu de connexion 
                  if(waitingRequestList.isNotEmpty){
                    for (String reqJson in waitingRequestList){
                      Api.send(RequeteType.post, reqJson);
                    }
                    Provider.of<ProductListProvider>(context, listen: false).setProduitListRequetesEmpty();
                  }
                }else{
                  Provider.of<ProductListProvider>(context, listen: false).addProduitListRequetes(jsonProduct); // Ajout d'un produit a la liste si il n'y a pas de connexion
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const WelcomeScreen())); // Redirection vers la page d'accueil
              },
              child: const Text('Ajouter le produit'),
            ),
          ],
        ),
      ),
    );
  }
}
