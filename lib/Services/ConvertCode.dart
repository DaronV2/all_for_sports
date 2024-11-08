import 'dart:math';

class ConvertCode {
  // Map pour stocker les correspondances entre fournisseurs et codes de base
  // static const Map<String, String> _supplierCodes = {
  //   'Decathlon': 'Dec',
  //   'Intersport': 'Int',
  //   'Nike': 'Nik',
  //   'Adidas': 'Adi',
  //   'Puma': 'Pum',
  //   'UnderArmour': 'Und',
  //   'NewBalance': 'New',
  //   'Reebok': 'Ree',
  //   'Asics': 'Asi',
  //   'Salomon': 'Sal',
  // };

  // Méthode pour transformer le code client en code fournisseur
  static String transform(String codeClient, String supplierName) {
    String? supplierPrefix = supplierName.substring(0,3);

    // Génère un code aléatoire de 8 caractères
    String randomCode = _generateRandomString(8);

    // Forme le code final avec les 3 premières lettres du fournisseur + SPO + 8 caractères aléatoires
    String supplierProductCode =
        '${supplierPrefix.toUpperCase()}SPO$randomCode';

    return supplierProductCode;
  }

  // Méthode privée pour générer une chaîne de caractères aléatoires de longueur donnée
  static String _generateRandomString(int length) {
    const String chars = '0123456789';
    Random random = Random();

    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  static bool clientCodeIsValid(String clientCodeScanned){
    RegExp regex = RegExp(r'[A-Z][A-Z][A-Z]CLI\d{8}$');
    if(regex.hasMatch(clientCodeScanned)){
      return true;
    }
    return false;
  }
}
