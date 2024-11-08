import 'package:flutter/material.dart';
import 'FlashQRCodeScreen.dart';
import 'ProductListScreen.dart';

/// Classe représentant la page d'accueil de l'application.
/// Elle propose deux boutons permettant de naviguer vers la liste des produits ou vers la page de scan de QR code.
class WelcomeScreen extends StatelessWidget {
  // Constructeur de la classe WelcomeScreen.
  // Paramètre optionnel `key` utilisé pour identifier de manière unique le widget dans l'arbre des widgets.
  const WelcomeScreen({Key? key}) : super(key: key);

  /// Méthode principale pour construire l'interface utilisateur de la page d'accueil.
  /// Retourne un widget `Scaffold` contenant l'AppBar et deux boutons de navigation.
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
