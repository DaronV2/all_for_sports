import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Classe `FlashQRCodeScreen`
///
/// Cette classe est un widget `StatefulWidget` qui représente l'écran
/// permettant de scanner un QR code et d'afficher le résultat.
class FlashQRCodeScreen extends StatefulWidget {
  const FlashQRCodeScreen({super.key});

  @override
  State<FlashQRCodeScreen> createState() => _FlashQRCodeScreenState();
}

/// Classe `_FlashQRCodeScreenState`
///
/// Cette classe représente l'état de `FlashQRCodeScreen` et contient
/// la logique pour scanner un QR code et afficher le résultat.
class _FlashQRCodeScreenState extends State<FlashQRCodeScreen> {
  // Variable pour stocker le résultat du scan QR code
  String? scanResult;

  /// Méthode `build` :
  ///
  /// Cette méthode construit l'interface utilisateur du scanner de QR code,
  /// avec une caméra pour scanner les QR codes et un affichage du résultat du scan.
  ///
  /// Paramètre :
  /// - `context`: le contexte de construction du widget.
  ///
  /// Retourne :
  /// - Un widget `Scaffold` contenant l'interface complète.
  @override
  Widget build(BuildContext context) {
    // Variable locale pour stocker temporairement la référence du produit scanné
    String? refProduitQrCode = '';

    return Scaffold(
      appBar: AppBar(
        // Titre de l'application dans la barre supérieure
        title: const Text('Scanner un produit'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            // Widget prenant 5/6 de l'espace vertical pour afficher la caméra du scanner
            flex: 5,
            child: MobileScanner(
              /// Méthode `onDetect` :
              ///
              /// Cette méthode est déclenchée lorsqu'un ou plusieurs QR codes sont détectés.
              /// Elle utilise `BarcodeCapture` pour récupérer les informations du QR code scanné.
              /// Le résultat est ensuite mis à jour dans l'interface en appelant `setState`.
              ///
              /// Paramètre :
              /// - `barcodeCapture`: un objet `BarcodeCapture` contenant les informations
              ///   des QR codes détectés.
              onDetect: (BarcodeCapture barcodeCapture) {
                // Liste des codes barres détectés
                final List<Barcode> barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  setState(() {
                    // `scanResult` reçoit la valeur brute (rawValue) du QR code détecté
                    scanResult = barcode.rawValue;
                    // On met également à jour `refProduitQrCode` avec le résultat du scan
                    refProduitQrCode = scanResult;
                    // Affichage dans la console de la référence du produit
                    print(refProduitQrCode);
                  });
                }
              },
            ),
          ),
          Expanded(
            // Widget prenant 1/6 de l'espace vertical pour afficher le texte du résultat
            flex: 1,
            child: Center(
              // Affiche le résultat du scan s'il est disponible, sinon un message par défaut
              child: Text(
                scanResult != null
                    ? 'Résultat du scan: $scanResult'
                    : 'Scannez un QR code', // Message d'instruction par défaut
              ),
            ),
          ),
        ],
      ),
    );
  }
}
