import 'package:all_for_sports/Screens/ProductList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
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
      home:
          const ProductListScreen(), // Affiche directement la liste des produits
    );
  }
}
