import 'package:flutter/material.dart';

class EntrepotProvider with ChangeNotifier {
  String _entrepot = '';

  // Getter pour récupérer l'entrepôt
  String get entrepot => _entrepot;

  // Setter pour mettre à jour l'entrepôt et notifier les listeners
  void setEntrepot(String value) {
    _entrepot = value;
    notifyListeners(); // Notifie toutes les pages écoutant ce changement
  }
}
