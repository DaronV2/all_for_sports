import 'package:all_for_sports/Screens/AccueilScreen.dart';
import 'package:all_for_sports/services/ConnexionTemp.dart';
import 'package:all_for_sports/services/SerializeLogs.dart';
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
    super.initState();
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
    String messageSnackBar = "";
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
          ),
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  messageSnackBar = "";
                  SerializeLogs logs = SerializeLogs(
                      _controllerId.text, _controllerPassword.text);
                  // String jsonString = jsonEncode(logs.toJson());
                  if (Connexiontemp.checkLogs(logs.id, logs.password)) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((BuildContext context) => const AccDart()),
                    ));
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
        ]),
      ),
    );
  }
}
