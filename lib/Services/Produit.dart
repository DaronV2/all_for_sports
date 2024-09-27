import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Produit {
  Produit(this.productRef, this.entrepot, this.quantite); // Constructeur

  final String productRef;
  final String entrepot;
  final int quantite;

  Map<String, dynamic> toJson() => {
        'productRef':
            productRef, //Entrer "produitRef" : ProduitRef , dans le json
        'entrepot': entrepot, // Entrer "entrepot" : entrepot , dans le json
        'quantite': quantite, //Entrer "quatite" : quantite , dans le json
      };
}
