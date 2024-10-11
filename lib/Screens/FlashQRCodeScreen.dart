import 'package:all_for_sports/Screens/AddProductScreen.dart';
import 'package:all_for_sports/Services/ConvertCode.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:all_for_sports/Screens/AddProductScreen.dart';

class FlashQRCodeScreen extends StatefulWidget {
  const FlashQRCodeScreen({super.key});

  @override
  State<FlashQRCodeScreen> createState() => _FlashQRCodeScreenState();
}

class _FlashQRCodeScreenState extends State<FlashQRCodeScreen> {
  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    String refProduitQrCode =
        ''; // Variavle qui va contenir la reference produit
    String scanResult = ''; // Variable qui va contenir le résultat du QR code
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
                if (!isScanning) return;
                final List<Barcode> barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  setState(() {
                    scanResult = barcode.rawValue.toString();
                    String referenceCodeClient = scanResult;
                    refProduitQrCode =
                        ConvertCode.transform(referenceCodeClient, "DECATHLON");
                    print(' ici present : $refProduitQrCode');
                    // Provider.setRefProduit(refProduitQrCode);
                    setState(() {});
                    if (ConvertCode.clientCodeIsValid(refProduitQrCode)) {
                      isScanning = false;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddProductScreen()));
                    }
                    // Mettre à jour la valeur dans le Provider
                    // if (scanResult != null) {
                    //   context
                    //       .read<EntrepotProvider>()
                    //       .setRefProduit(scanResult!);
                    // }
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
              if (refProduitQrCode == '') {}
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
