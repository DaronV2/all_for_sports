import 'package:flutter/material.dart';

class EntrepotProvider with ChangeNotifier {
  String _entrepot = '';
  String _refProduitPourPageAddProduct = '';

  // Getter pour récupérer l'entrepôt
  String get entrepot => _entrepot;

  // Getter pour récupérer refProduitPourPageAddProduct
  String get refProduit => _refProduitPourPageAddProduct;

  // Setter pour mettre à jour l'entrepôt et notifier les listeners
  void setEntrepot(String value) {
    _entrepot = value;
    notifyListeners(); // Notifie toutes les pages écoutant ce changement
  }

  // Setter pour mettre à jour l'entrepôt et notifier les listeners
  void setRefProduit(String value) {
    _refProduitPourPageAddProduct = value;
    notifyListeners(); // Notifie toutes les pages écoutant ce changement
  }
}
