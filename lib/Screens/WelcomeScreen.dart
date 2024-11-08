import 'package:all_for_sports/Screens/FlashQRCodeScreen.dart';
import 'package:all_for_sports/Screens/ProductListScreen.dart';
import 'package:all_for_sports/Services/ConnexionCheck.dart';
import 'package:all_for_sports/Services/ConnexionProvider.dart';
import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Connexioncheck.checkConnectivity(context);
  }

  /// Méthode principale pour construire l'interface utilisateur de la page d'accueil.
  /// Retourne un widget `Scaffold` contenant l'AppBar et deux boutons de navigation.
  @override
  Widget build(BuildContext context) {
    bool visible = Provider.of<ConnexionProvider>(context).connexion;
    return Scaffold(
      // Barre d'application affichant le titre de la page.
      appBar: AppBar(
        title: const Text('Page d\'Accueil - AccDart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Premier bouton pour naviguer vers la liste des produits.
            ElevatedButton(
              onPressed: () {
                // Navigation vers la page `ProductListScreen`.
                // Retourne une instance de `ProductListScreen`.

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              },
              child: const Text('Aller à la Liste des Produits'),
            ),
            const SizedBox(height: 20), // Espacement entre les boutons
            ElevatedButton(
              onPressed: () {
                // Navigation vers la Page Liste Produit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FlashQRCodeScreen()),
                );
              },
              child: const Text('Aller à la PageQRCode'),
            ),
            Visibility(
              visible: !visible,
              child: ElevatedButton(
                onPressed: () {
                  Connexioncheck.checkConnectivity(context);
                },
                child: const Icon(Icons.network_check),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // N'oubliez pas de vous désabonner lorsque le widget est détruit
    super.dispose();
  }
}
