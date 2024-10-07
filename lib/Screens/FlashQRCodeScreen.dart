import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
                    refProduitQrCode = scanResult;
                    print(refProduitQrCode);
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
        ],
      ),
    );
  }
}
