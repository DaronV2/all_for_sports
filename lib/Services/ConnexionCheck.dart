import 'package:all_for_sports/Screens/ConnexionScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Connexioncheck {
  static Future<void> checkConnectivity(BuildContext context) async {
    final Connectivity _connectivity = Connectivity();
    try {
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      if (result.contains(ConnectivityResult.none)) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const ConnexionScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Vous êtes connecté à internet veuillez-vous connecter à l'application afin de synchroniser vos informations"),
            duration: Duration(seconds: 20), // Durée d'affichage de la SnackBar
          ),
        );
      }
    } catch (e) {
      print('Erreur de connectivité : $e');
    }
  }
}
