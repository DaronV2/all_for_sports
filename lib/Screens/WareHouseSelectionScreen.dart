import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:all_for_sports/Screens/WelcomeScreen.dart';

/// Écran permettant la sélection d'un entrepôt.
/// Affiche une liste déroulante des entrepôts disponibles avec leurs coordonnées GPS et le nom de la ville.
class WareHouseSelectionScreen extends StatelessWidget {
  // Liste des entrepôts disponibles avec leurs coordonnées GPS et la ville.
  final List<Map<String, dynamic>> warehouses = [
    {
      "latitude": 50.3592,
      "longitude": 3.5253,
      "city": "Valenciennes"
    }, //TODO changer Valenciennes par Lyon
    {"latitude": 49.4944, "longitude": 0.1079, "city": "Le Havre"},
    {"latitude": 43.2965, "longitude": 5.3698, "city": "Marseille"},
  ]; // Coordonnées GPS des villes où il y a des entrepots

  /// Méthode `build` pour construire l'interface utilisateur de la page de sélection d'entrepôt.
  /// Prend un `BuildContext` comme paramètre et retourne un widget `Scaffold`.
  @override
  Widget build(BuildContext context) {
    // Récupère le nom de l'entrepôt sélectionné via le provider WareHouseProvider.
    String selectedWarehouse = context.watch<WareHouseProvider>().entrepot;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionnez un Entrepôt'),
      ),
      body: Center(
        child: DropdownButton<String>(
          // Texte affiché quand aucun entrepôt n'est sélectionné
          hint: Text('Sélectionnez un entrepôt'),
          // Valeur sélectionnée. Null si aucun entrepôt n'a encore été choisi
          value: selectedWarehouse.isNotEmpty ? selectedWarehouse : null,
          // Callback appelé lorsque l'utilisateur sélectionne un nouvel entrepôt
          onChanged: (String? newValue) {
            if (newValue != null) {
              // Mise à jour de l'entrepôt sélectionné dans le provider
              context.read<WareHouseProvider>().setEntrepot(newValue);

              // Navigation vers la page d'accueil après sélection
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            }
          },

          // Création de la liste des éléments du menu déroulant avec les noms des villes d'entrepôts
          items: warehouses.map((warehouse) {
            return DropdownMenuItem<String>(
              // Nom de la ville sélectionnée comme valeur
              value: warehouse['city'],
              child: Text(warehouse['city']),
            );
          }).toList(),
        ),
      ),
    );
  }
}
