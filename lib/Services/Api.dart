import 'package:http/http.dart' as http;
import 'package:http/http.dart'; // https://docs.flutter.dev/cookbook/networking/fetch-data
import 'dart:convert'; // Pour utiliser jsonDecode

class Api {
  // Focntion pour appeler l'api locale 
  static Future<Response> fetchApi(String apiPage) async {
    var url = Uri.http('127.0.0.1:30000', apiPage);
    return await http.get(url);
  }

  // Méthode pour extraire la référence du produit à partir du JSON
  static String extractProductReference(String codeJsonPourAPI) { // TODO expliquer code 
    // Décodage du JSON pour obtenir la map des données
    Map<String, dynamic> productData = jsonDecode(codeJsonPourAPI);

    // Extraction de la référence du produit
    String productReference = productData['productRef'];

    String messageErreur = 'OK';

    if (productReference == "DECSPO124d48f1h9t1") {
      messageErreur = 'Erreur De Connexion';
      return messageErreur;
    } else if (productReference == "DECSPO124d48f1h9t2") {
      messageErreur = 'Produit Inexistant';
      return messageErreur;
    } else if (productReference == "DECSPO124d48f1h9t3") {
      messageErreur = 'Erreur lors de la connexion';
      return messageErreur;
    } else {
      return messageErreur;
    }
  }

  static send(RequeteType req, String chaineJson){
    if(req == RequeteType.get){
      print("get : "+ chaineJson);
    }else{
      print("Post : "+ chaineJson);
    }
  }
}

enum RequeteType{
  get,
  post
}
