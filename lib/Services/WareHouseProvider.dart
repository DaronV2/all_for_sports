import 'package:flutter/material.dart';

class WareHouseProvider with ChangeNotifier {
  static String _entrepot = '';

  static String _refProduitPourPageAddProduct = '';

  static List<String> _listRequete = []; // TODO mettre en bdd les requetes 

  // Getter pour récupérer l'entrepôt
  String get entrepot => _entrepot;

  // Getter pour récupérer refProduitPourPageAddProduct
  String get refProduit => _refProduitPourPageAddProduct;

  List<String> get listRequete => _listRequete;

  // Setter pour mettre à jour l'entrepôt et notifier les listeners
  void setEntrepot(String value) {
    _entrepot = value;
    notifyListeners(); // Notifie toutes les pages écoutant ce changement
  }


  static String getEntrepot(){
    return _entrepot;
  }

  static String getRefProduct(){
    return _refProduitPourPageAddProduct;
  }

  // Setter pour mettre à jour l'entrepôt et notifier les listeners
  void setRefProduit(String value) {
    _refProduitPourPageAddProduct = value;
    notifyListeners(); // Notifie toutes les pages écoutant ce changement
  }

  static getListRequetes(){
    return _listRequete;
  }

  void addProduitListRequetes(String value){
    _listRequete.add(value);
    notifyListeners();
  }

  void setProduitListRequetesEmpty(){
    _listRequete = [];
  }
}
