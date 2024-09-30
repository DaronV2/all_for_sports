import 'dart:math';

class ProductCodeTransformer {
  // Map pour stocker les correspondances entre fournisseurs et codes de base
  static const Map<String, String> _supplierCodes = {
    'Decathlon': 'Dec',
    'Intersport': 'Int',
    'Nike': 'Nik',
    'Adidas': 'Adi',
    'Puma': 'Pum',
    'UnderArmour': 'Und',
    'NewBalance': 'New',
    'Reebok': 'Ree',
    'Asics': 'Asi',
    'Salomon': 'Sal',
    // Ajoutez d'autres fournisseurs ici si nécessaire
  };

  // Méthode pour transformer le code client en code fournisseur
  static String transform(String supplierName) {
    // Vérifie si le fournisseur existe dans le map
    String? supplierPrefix = _supplierCodes[supplierName];

    // Si le fournisseur n'existe pas, renvoie un message d'erreur
    if (supplierPrefix == null) {
      throw Exception('Fournisseur non reconnu: $supplierName');
    }

    // Génère un code aléatoire de 8 caractères
    String randomCode = _generateRandomString(8);

    // Forme le code final avec les 3 premières lettres du fournisseur + SPO + 8 caractères aléatoires
    String supplierProductCode =
        '${supplierPrefix.toUpperCase()}SPO$randomCode';

    print(supplierProductCode);

    return supplierProductCode;
  }

  // Méthode privée pour générer une chaîne de caractères aléatoires de longueur donnée
  static String _generateRandomString(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();

    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
}
