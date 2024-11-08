import 'package:flutter/material.dart';

class ConnexionProvider with ChangeNotifier{

    static bool _connexion = false;

  bool get connexion => _connexion;

  static bool getConnexionState(){
    return _connexion;
  }

  void setConnexionState(bool value){
    _connexion = value;
    notifyListeners();
  }
}