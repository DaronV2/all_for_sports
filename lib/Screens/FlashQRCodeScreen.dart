import 'dart:async';
import 'package:all_for_sports/Screens/AddProductScreen.dart';
import 'package:all_for_sports/Services/ConvertCode.dart';
import 'package:all_for_sports/Services/ProductReferenceProvider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class FlashQRCodeScreen extends StatefulWidget {
  const FlashQRCodeScreen({super.key});

  @override
  State<FlashQRCodeScreen> createState() => _FlashQRCodeScreenState();
}

class _FlashQRCodeScreenState extends State<FlashQRCodeScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controllerQrCode = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  // Fonction _handleBarcode : 
  //  paramètres : 
  //    - BarcodeCapture barcodes, contient les QR Codes scannés par l'appli
  //  Retourne Rien 
  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
        String? referenceCodeClient = _barcode?.rawValue; // Récupérér la valeur du QR Code
        if (referenceCodeClient != null) {
          if (ConvertCode.clientCodeIsValid(referenceCodeClient)/* Focntion qui utilise un regex pour vérifier la valeur du QR Code */ ) {
            String refProduitQrCode = ConvertCode.transform(referenceCodeClient,
                "DECATHLON"); // Ici a faire avec l'API pour gerer code ( Faire dico de code fournisseur et code a nous)
            Provider.of<ProductReferenceProvider>(context, listen: false)
                .setRefProduit(refProduitQrCode); // Mettre la référence produit récupérée par le QR Code dans le provider
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const AddProductScreen())); // Redirection vers la page Ajouter produit
            dispose();
          }
        }
      });
    }
  }

 // Fonction nécessaire au bon fonctionnement du widget de scan de QR Code
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = _controllerQrCode.barcodes.listen(_handleBarcode);

    unawaited(_controllerQrCode.start());
  }

 // Fonction nécessaire au bon fonctionnement du widget de scan de QR Code
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controllerQrCode.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = _controllerQrCode.barcodes.listen(_handleBarcode);

        unawaited(_controllerQrCode.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controllerQrCode.stop());
      // return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner un produit'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: MobileScanner(
              controller: _controllerQrCode,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await _controllerQrCode.dispose();
  }
}
