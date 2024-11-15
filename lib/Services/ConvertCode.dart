import 'dart:math';

class ConvertCode {
  // Fonction transform : 
  //  paramètres : 
  //    - String codeClient, variable qui contient le codeClient scanné par le QR Code
  //    - String SupplierName, qui contient le nom du founisseur du produit
  //  Retourne String referenceProduit 
  static String transform(String codeClient, String supplierName) {
    String? supplierPrefix = supplierName.substring(0,3);

    // Génère un code aléatoire de 8 caractères
    String randomCode = _generateRandomString(8);

    // Forme le code final avec les 3 premières lettres du fournisseur + SPO + 8 caractères aléatoires
    String supplierProductCode =
        '${supplierPrefix.toUpperCase()}SPO$randomCode';

    return supplierProductCode;
  }

  // Fonction _generateRandomString : 
  //  paramètres : 
  //    - int length, qui contient la longueur de la chaine de caracteres a retournée demandee
  //  Retourne Une String de longueur length de caractères aleatoires
  static String _generateRandomString(int length) {
    const String chars = '0123456789';
    Random random = Random();

    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  // Fonction redirection : 
  //  paramètres : 
  //    - String clientCodeScanned, qui contient la reference produit 
  //  Retourne vrai si la référence produit est bonne sinon faux
  static bool clientCodeIsValid(String clientCodeScanned){
    RegExp regex = RegExp(r'[A-Z][A-Z][A-Z]CLI\d{8}$');
    if(regex.hasMatch(clientCodeScanned)){
      return true;
    }
    return false;
  }
}
