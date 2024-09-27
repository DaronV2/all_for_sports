import 'package:flutter/material.dart';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("App"),
        ),
        body: Stack(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Entrez votre identifiant : ",
                contentPadding: EdgeInsets.all(5),
                border: OutlineInputBorder(),
              ),
            )
          ]
        ),
      ),
    );
  }
}
