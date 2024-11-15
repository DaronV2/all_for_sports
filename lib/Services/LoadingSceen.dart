import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        // Si en train de charger, montrer l'indicateur de progression
        // Sinon afficher le contenu principal
        child: isLoading
            ? const CircularProgressIndicator() // Indicateur de chargement
            : const Text(
                'Contenu chargé avec succès !'), // Contenu après le chargement
      ),
    );
  }
}
