import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

//Widget d'état, car la position peut changer au fil du temps
class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _locationMessage = "Récupération de la position...";

  // Fonction pour obtenir la localisation
  Future<void> recuperationDeLaPositionDeLappareil() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Le Service de localisation ne fonctionne pas !";
      });
      return;
    }

    // Vérifier les permissions de localisation
    // checkPermission() : Vérifie si l'application a les autorisations nécessaires pour accéder à la localisation.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // requestPermission() : Si l'autorisation est refusée, cette méthode demande à nouveau à l'utilisateur d'autoriser la localisation.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage =
              "La localisation de votre position n'est pas autorisé";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Location permissions are permanently denied";
      });
      return;
    }

    /*
    // Obtenir la position actuelle
    Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high); */

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    setState(() {
      _locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
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
