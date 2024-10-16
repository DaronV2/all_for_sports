import 'package:all_for_sports/Screens/ConnexionScreen.dart';
import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Fournir EntrepotProvider à toute l'application
      create: (context) => WareHouseProvider(),
      child: MaterialApp(
        title: 'ALL4SPORT App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ConnexionScreen(), // Page d'accueil de l'application
      ),
    );
  }
}
