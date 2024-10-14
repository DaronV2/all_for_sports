import 'package:all_for_sports/Screens/AddProductScreen.dart';
import 'package:all_for_sports/Services/ConvertCode.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:all_for_sports/Services/WareHouseProvider.dart';

class FlashQRCodeScreen extends StatefulWidget {
  const FlashQRCodeScreen({super.key});

  @override
  State<FlashQRCodeScreen> createState() => _FlashQRCodeScreenState();
}

class _FlashQRCodeScreenState extends State<FlashQRCodeScreen> {
  bool isScanning = true;

  MobileScannerController qrCodeController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    qrCodeController.start();
    // qrCodeController.detectionSpeed = DetectionSpeed.noDuplicates;
    String refProduitQrCode =
        ''; // Variavle qui va contenir la reference produit
    String scanResult = ''; // Variable qui va contenir le résultat du QR code
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner un produit'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: MobileScanner(
              controller: qrCodeController,
              onDetectError: (Object error, StackTrace stack) {
                print("ici : $error");
              },
              onDetect: (BarcodeCapture barcodeCapture) {
                try {
                  if (!isScanning) return;
                  final List<Barcode> barcodes = barcodeCapture.barcodes;
                  for (final barcode in barcodes) {
                    setState(() {
                      scanResult = barcode.rawValue.toString();
                      String referenceCodeClient = scanResult;
                      refProduitQrCode = ConvertCode.transform(
                          referenceCodeClient, "DECATHLON");
                      Provider.of<WareHouseProvider>(context, listen: false)
                          .setRefProduit(refProduitQrCode);
                      if (ConvertCode.clientCodeIsValid(refProduitQrCode)) {
                        isScanning = false;
                        qrCodeController.stop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const AddProductScreen()));
                      }
                    });
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Text("test"),
            onPressed: () {
              // qrCodeController.stop();
              // qrCodeController.stop();
              int? cam = qrCodeController.value.availableCameras;
              MobileScannerException? xcept = qrCodeController.value.error;
              var details = xcept?.errorDetails?.details;
              print("$xcept , le nombre de camera dispo : $cam, details : $details");
            },
          )
        ],
      ),
    );
  }
}
