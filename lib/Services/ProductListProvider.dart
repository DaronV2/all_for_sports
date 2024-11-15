import 'package:flutter/material.dart';

class ProductListProvider with ChangeNotifier {
  static List<String> _listRequete = []; // TODO mettre en bdd les requetes 

  List<String> get listRequete => _listRequete;

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