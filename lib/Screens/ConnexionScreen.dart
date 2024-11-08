import 'package:all_for_sports/Screens/WareHouseSelectionScreen.dart';
import 'package:all_for_sports/Screens/WelcomeScreen.dart';
import 'package:all_for_sports/Screens/ChoosingAWarehouseScreen.dart';
import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:all_for_sports/services/ConnexionTemp.dart';
import 'package:all_for_sports/services/SerializeLogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  bool _passwordHidden = true;

  final TextEditingController _controllerLogin = TextEditingController();
  // Controller pour le textfield du login
  final TextEditingController _controllerPassword = TextEditingController();
  // Controller pour le textfield du mot de passe

  @override
  void initState() {
    super.initState();
    _passwordHidden = true; // Variable qui permet de cacher le mot de passe
  }

  void redirection(BuildContext context, [bool? disconnected]) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => WareHouseSelectionScreen()));
    if (disconnected != null && disconnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Vous etes en mode déconnecté !'),
          duration: Duration(days: 1), // Durée d'affichage du SnackBar
          dismissDirection: DismissDirection.none,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String messageSnackBar =
        ""; // Variable qui contient le message a afficher dans la SnackBar
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("App"),
          ),
        ),
        body: Column(children: [
          TextFormField(
            controller: _controllerLogin,
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
          ),
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  messageSnackBar = "";
                  SerializeLogs logs = SerializeLogs(
                      _controllerLogin.text, _controllerPassword.text);
                  // String jsonString = jsonEncode(logs.toJson());
                  if (Connexiontemp.checkLogs(logs.id, logs.password)) {
                    redirection(context);
                  } else {
                    if (!Connexiontemp.checkLogin(logs.id)) {
                      messageSnackBar += "Login incorrect ";
                    }
                    if (!Connexiontemp.checkPassword(logs.password)) {
                      messageSnackBar += "Mot de passe Incorrect.";
                    }
                    // Si la connexion échoue, afficher une SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(messageSnackBar),
                      // duration: Duration(seconds: 3),
                    ));
                  }
                },
                child: const Text("Connecter"),
              );
            },
          ),
          ElevatedButton(
              onPressed: () {
                redirection(context, true);
              },
              child: Text("Se connecter en mode hors ligne"))
        ]),
      ),
    );
  }
}
