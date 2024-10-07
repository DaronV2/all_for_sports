import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:all_for_sports/Services/Provides.dart';
import 'package:all_for_sports/Screens/AddProductScreen.dart';

class FlashQRCodeScreen extends StatefulWidget {
  const FlashQRCodeScreen({super.key});

  @override
  State<FlashQRCodeScreen> createState() => _FlashQRCodeScreenState();
}

class _FlashQRCodeScreenState extends State<FlashQRCodeScreen> {
  String? scanResult;

  @override
  Widget build(BuildContext context) {
    String? refProduitQrCode = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner un produit'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: MobileScanner(
              onDetect: (BarcodeCapture barcodeCapture) {
                final List<Barcode> barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  setState(() {
                    scanResult = barcode
                        .rawValue; // Utiliser rawValue pour obtenir la valeur du QR code
                    // Mettre à jour la valeur dans le Provider
                    if (scanResult != null) {
                      context
                          .read<EntrepotProvider>()
                          .setRefProduit(scanResult!);
                    }
                  });
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                scanResult != null
                    ? 'Résultat du scan: $scanResult'
                    : 'Scannez un QR code',
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Bouton pour aller sur la page AddProduct
          ElevatedButton(
            onPressed: () {
              // Navigation vers la page AddProductScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddProductScreen()),
              );
            },
            child: const Text('Ajouter un produit'),
          ),
        ],
      ),
    );
  }
}
