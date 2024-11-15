import 'package:all_for_sports/Screens/ConnexionScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Connexioncheck {
  //Fonction qui permet de savoir si on est connecté ou non 
  static Future<void> checkConnectivity(BuildContext context) async {
    final Connectivity connectivity = Connectivity();
    try {
      List<ConnectivityResult> result = await connectivity.checkConnectivity(); // Récupérer données de connexion
      if (result.contains(ConnectivityResult.none)) { // Si il n'y a pas de connexion
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
