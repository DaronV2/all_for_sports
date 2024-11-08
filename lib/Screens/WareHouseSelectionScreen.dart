import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:all_for_sports/Screens/WelcomeScreen.dart';

class WareHouseSelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> warehouses = [
    {"latitude": 50.3592, "longitude": 3.5253, "city": "Valenciennes"}, //TODO changer Valenciennes par Lyon
    {"latitude": 49.4944, "longitude": 0.1079, "city": "Le Havre"},
    {"latitude": 43.2965, "longitude": 5.3698, "city": "Marseille"},
  ];                                                                // Coordonnées GPS des villes où il y a des entrepots

  @override
  Widget build(BuildContext context) {
    String selectedWarehouse = context.watch<WareHouseProvider>().entrepot;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionnez un Entrepôt'),
      ),
      body: Center(
        child: DropdownButton<String>(
          hint: const Text('Sélectionnez un entrepôt'),
          value: selectedWarehouse.isNotEmpty ? selectedWarehouse : null,
          onChanged: (String? newValue) {
            if (newValue != null) {
              context.read<WareHouseProvider>().setEntrepot(newValue);

              // Redirection vers la page AccDart après la sélection
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            }
          },
          items: warehouses.map((warehouse) {
            return DropdownMenuItem<String>(
              value: warehouse['city'],
              child: Text(warehouse['city']),
            );
          }).toList(),
        ),
      ),
    );
  }
}
