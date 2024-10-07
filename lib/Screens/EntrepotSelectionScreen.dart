import 'package:all_for_sports/Services/Provides.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:all_for_sports/Screens/AccueilScreen.dart';

class EntrepotSelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> warehouses = [
    {"latitude": 50.3592, "longitude": 3.5253, "city": "Valenciennes"},
    {"latitude": 49.4944, "longitude": 0.1079, "city": "Le Havre"},
    {"latitude": 43.2965, "longitude": 5.3698, "city": "Marseille"},
  ];

  @override
  Widget build(BuildContext context) {
    String selectedWarehouse = context.watch<EntrepotProvider>().entrepot;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sélectionnez un Entrepôt'),
      ),
      body: Center(
        child: DropdownButton<String>(
          hint: Text('Sélectionnez un entrepôt'),
          value: selectedWarehouse.isNotEmpty ? selectedWarehouse : null,
          onChanged: (String? newValue) {
            if (newValue != null) {
              context.read<EntrepotProvider>().setEntrepot(newValue);

              // Redirection vers la page AccDart après la sélection
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AccDart()),
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
