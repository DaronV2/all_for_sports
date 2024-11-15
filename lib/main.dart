import 'package:all_for_sports/Screens/ConnexionScreen.dart';
import 'package:all_for_sports/Services/ConnexionProvider.dart';
import 'package:all_for_sports/Services/ProductListProvider.dart';
import 'package:all_for_sports/Services/ProductReferenceProvider.dart';
import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider( // Initialisation des Providers de l'application
    providers: [
      ChangeNotifierProvider(create: (_) => ConnexionProvider()),
      ChangeNotifierProvider(create: (_) => WareHouseProvider()),
      ChangeNotifierProvider(create: (_) => ProductListProvider()),
      ChangeNotifierProvider(create: (_) => ProductReferenceProvider()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ALL4SPORT App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ConnexionScreen(), // Redirection vers la page de connexion 
      );
  }
}
