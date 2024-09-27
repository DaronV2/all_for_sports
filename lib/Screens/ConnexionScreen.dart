import 'dart:convert';

import 'package:all_for_sports/Services/SerializeLogs.dart';
import 'package:flutter/material.dart';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {

  bool _passwordHidden = true;

  final TextEditingController _controllerId = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    _passwordHidden = true;
    // TODO: implement initState
    // super.initState();
    // _controllerId.addListener(() {
    //   final String textId = _controllerId.text.toLowerCase();
    //   // print(textId);
    // });
    // _controllerPassword.addListener(() {
    //   final String textPassword = _controllerPassword.text;
    //   // print(textPassword);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("App"),
          ),
        ),
        body: Column(children: [
          TextFormField(
            controller: _controllerId,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: "Entrez votre identifiant : ",
            ),
          ),
          TextFormField(
            controller: _controllerPassword,
            obscureText: _passwordHidden,
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              hintText: "Entrez votre Mot de passe : ",
            ),
            // onChanged: (_controllerPassword) {
            //   print(_controllerPassword);
            // },
          ),
          ElevatedButton(
            onPressed: () {
              SerializeLogs logs = SerializeLogs(_controllerId.text, _controllerPassword.text);
              String jsonString = jsonEncode(logs.toJson());
              print(jsonString);
            },
            child: const Text("Connecter"),
          ),
        ]),
      ),
    );
  }
}
