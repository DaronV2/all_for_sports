import 'package:all_for_sports/Screens/AddProductScreen.dart';
import 'package:all_for_sports/Services/ConvertCode.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class FlashQRCodeScreen extends StatefulWidget {
  const FlashQRCodeScreen({super.key});

  @override
  State<FlashQRCodeScreen> createState() => _FlashQRCodeScreenState();
}

class _FlashQRCodeScreenState extends State<FlashQRCodeScreen> {
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
                final List<Barcode> barcodes = barcodeCapture.barcodes;
                for (final barcode in barcodes) {
                  setState(() {
                    scanResult = barcode.rawValue.toString();
                    String referenceCodeClient = scanResult;
                    print(referenceCodeClient);
                    refProduitQrCode =
                        ConvertCode.transform(referenceCodeClient);
                    print(refProduitQrCode);
                    if (ConvertCode.clientCodeIsValid(refProduitQrCode)) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddProductScreen()));
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
        ],
      ),
    );
  }
}
