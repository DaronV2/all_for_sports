import 'package:all_for_sports/Screens/AccueilScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:all_for_sports/Services/Provides.dart';
import 'package:provider/provider.dart';
import 'package:all_for_sports/Screens/EntrepotSelectionScreen.dart';

// Widget d'état, car la position peut changer au fil du temps
class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _locationMessage = "Récupération de la position...";
  // Variable pour stocker l'entrepôt le plus proche
  String? _nearbyWarehouse;
  // String? _selectedWarehouse;

  // Getter pour accéder à l'entrepôt le plus proche
  String? get nearbyWarehouse => _nearbyWarehouse;

  // Positions des trois entrepôts (latitude, longitude, nom de la ville)
  final List<Map<String, dynamic>> warehouses = [
    {"latitude": 50.3592, "longitude": 3.5253, "city": "Valenciennes"},
    {"latitude": 49.4944, "longitude": 0.1079, "city": "Le Havre"},
    {"latitude": 43.2965, "longitude": 5.3698, "city": "Marseille"},
  ];

  // Fonction pour obtenir la localisation
  Future<void> recuperationDeLaPositionDeLappareil() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Le Service de localisation ne fonctionne pas !";
        Navigator.of(context).push(MaterialPageRoute(
          builder: ((BuildContext context) => EntrepotSelectionScreen()),
        ));
      });
      return;
    }

    // Vérifier les permissions de localisation
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage =
              "La localisation de votre position n'est pas autorisée.";
          Navigator.of(context).push(MaterialPageRoute(
            builder: ((BuildContext context) => EntrepotSelectionScreen()),
          ));
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            "Les permissions de localisation sont définitivement refusées.";
        Navigator.of(context).push(MaterialPageRoute(
          builder: ((BuildContext context) => EntrepotSelectionScreen()),
        ));
      });
      return;
    }

    // Obtenir la position actuelle
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    // Comparer la position actuelle avec les entrepôts
    String?
        nearbyWarehouse; // Variable pour stocker le nom de l'entrepôt proche

    for (var warehouse in warehouses) {
      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        warehouse["latitude"]!,
        warehouse["longitude"]!,
      );

      // Vérifier si la distance est inférieure à 2000 mètres (2 km)
      if (distanceInMeters < 10000) {
        nearbyWarehouse = warehouse["city"]; // Récupérer le nom de l'entrepôt
        break; // On sort de la boucle une fois qu'on a trouvé un entrepôt proche
      }
    }

    // Mettre à jour le message affiché et naviguer si un entrepôt est trouvé
    setState(() {
      if (nearbyWarehouse != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: ((BuildContext context) => AccDart()),
        ));
        // Mettre à jour le provider avec le nouveau nom de l'entrepôt
        Provider.of<EntrepotProvider>(context, listen: false)
            .setEntrepot(nearbyWarehouse);
      } else {
        _locationMessage = "Aucun entrepôt à moins de 4 km.";
        Navigator.of(context).push(MaterialPageRoute(
          builder: ((BuildContext context) => EntrepotSelectionScreen()),
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    recuperationDeLaPositionDeLappareil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCALISATION'),
      ),
      body: Center(
        child: Text(
          _locationMessage,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: recuperationDeLaPositionDeLappareil,
        child: const Icon(Icons.location_on),
      ),
    );
  }
}

// Nouvelle page pour afficher le nom de l'entrepôt
class WarehousePage extends StatelessWidget {
  final String warehouseName;

  const WarehousePage({super.key, required this.warehouseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrepôt Proche'),
      ),
      body: Center(
        child: Text(
          'Vous êtes proche de l\'entrepôt à : $warehouseName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
