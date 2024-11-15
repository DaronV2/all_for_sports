import 'package:flutter/material.dart';

class ProductReferenceProvider with ChangeNotifier{

  static String _refProduit = '';

  // Getter pour récupérer refProduitPourPageAddProduct
  String get refProduit => _refProduit;

  static String getRefProduct(){
    return _refProduit;
  }

  // Setter pour mettre à jour l'entrepôt et notifier les listeners
  void setRefProduit(String value) {
    _refProduit = value;
    notifyListeners(); // Notifie toutes les pages écoutant ce changement
  }
}