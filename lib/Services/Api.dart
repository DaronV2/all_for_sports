import 'package:http/http.dart' as http;

class Api {
  // Méthode pour envoyer le produit à l'API
  static Future<String> sendProductToApi(String CodeJsonPourAPI) async {
    var url = Uri.parse('https://API'); // URL de l'API

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: CodeJsonPourAPI,
      );

      if (response.statusCode == 200) {
        print('Produit ajouté avec succès');
        String message = 'Produit ajouté avec succès';
        return message;
      } else {
        print('Erreur: ${response.statusCode}');
        String message = 'Erreur: ${response.statusCode}';
        return message;
      }
    } catch (e) {
      print('Erreur lors de l\'envoi du produit: $e');
      String message = 'Erreur lors de l\'envoi du produit: $e';
      return message;
    }
  }
}
