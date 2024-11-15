import 'dart:async';
import 'package:all_for_sports/Screens/AddProductScreen.dart';
import 'package:all_for_sports/Services/ConvertCode.dart';
import 'package:all_for_sports/Services/ProductReferenceProvider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

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
class _FlashQRCodeScreenState extends State<FlashQRCodeScreen>
    with WidgetsBindingObserver {
  /// Contrôleur pour le scanner QR code.
  /// Configure les options comme la vitesse de détection et la gestion de la caméra.
  final MobileScannerController _controllerQrCode = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  Barcode? _barcode; // Stocke le QR code scanné.
  StreamSubscription<Object?>?
      _subscription; // Écoute les événements des QR codes scannés.

  /// Méthode `_buildBarcode` :
  ///
  /// Affiche un texte basé sur la valeur scannée.
  /// - Si aucune valeur n'est scannée : message par défaut.
  /// - Si une valeur est scannée : affiche son contenu.
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

  /// Méthode `_handleBarcode` :
  ///
  /// Logique de traitement des QR codes scannés.
  /// - Valide le code scanné via `ConvertCode.clientCodeIsValid`.
  /// - Transforme le code client en référence produit avec `ConvertCode.transform`.
  /// - Met à jour le `ProductReferenceProvider` et redirige vers l'écran d'ajout de produit.
  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
        String? referenceCodeClient = _barcode?.rawValue;

        if (referenceCodeClient != null) {
          if (ConvertCode.clientCodeIsValid(referenceCodeClient)) {
            String refProduitQrCode = ConvertCode.transform(
              referenceCodeClient,
              "DECATHLON",
            );

            Provider.of<ProductReferenceProvider>(context, listen: false)
                .setRefProduit(refProduitQrCode);

            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const AddProductScreen(),
            ));

            dispose(); // Termine l'écouteur et les ressources.
          }
        }
      });
    }
  }

  /// Méthode `initState` :
  ///
  /// Initialisation de l'état du widget.
  /// - Ajoute l'observateur des changements de cycle de vie.
  /// - Démarre le scanner QR code.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = _controllerQrCode.barcodes.listen(_handleBarcode);

    unawaited(_controllerQrCode.start());
  }

  /// Méthode `didChangeAppLifecycleState` :
  ///
  /// Gère les transitions entre les états de cycle de vie de l'application.
  /// - Arrête ou redémarre la caméra selon l'état.
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
        break;
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controllerQrCode.stop());
        break;
    }
  }

  /// Méthode `build` :
  ///
  /// Construit l'interface utilisateur du scanner QR code.
  /// - Inclut une caméra pour le scan et un affichage du résultat.
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

  /// Méthode `dispose` :
  ///
  /// Libère les ressources utilisées par le widget.
  /// - Arrête le scanner et nettoie les observateurs.
  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await _controllerQrCode.dispose();
  }
}
