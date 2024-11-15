import 'package:all_for_sports/Screens/ChoosingAWarehouseScreen.dart';
import 'package:all_for_sports/Services/ConnexionProvider.dart';
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
  // Booléen si mot de passe est caché ou non
  bool _passwordHidden = true;

  // Controller pour le textfield du login
  final TextEditingController _controllerLogin = TextEditingController();

  // Controller pour le textfield du mot de passe
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordHidden = true; // Variable qui permet de cacher le mot de passe
  }

  // Fonction redirection :
  //  paramètres :
  //    - BuildContext context , récupère le contexte d'un build
  //    - bool disconnected , paramètre facultatif, qui envoi sur la connexion est établie ou non
  //  Retourne Rien
  void redirection(BuildContext context, [bool? disconnected]) {
    if (disconnected != null && disconnected) {
      Provider.of<ConnexionProvider>(context, listen: false)
          .setConnexionState(false); // Mettre l'état de la cpnnexion a faux
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ChoosingAWareHouseScreen()));
    } else {
      Provider.of<ConnexionProvider>(context, listen: false)
          .setConnexionState(true); // Mettre l'état de la connexion a vrai
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ChoosingAWareHouseScreen()));
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
                      _controllerLogin.text,
                      _controllerPassword
                          .text); // Mettre les logs de connexion dans un objet
                  // String jsonString = jsonEncode(logs.toJson());
                  // Connexion temporaire sans API
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
              child: const Text("Se connecter en mode hors ligne"))
        ]),
      ),
    );
  }
}
