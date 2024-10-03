import 'package:all_for_sports/Services/Product.dart';

class ProductList {

  List<Product> productList  = [];

  ProductList([productList]){
    this.productList = productList;
  }

  factory ProductList.fromJson(Map<String, dynamic> json) {
    // Vérifie si 'Products' est bien une liste
    var list = json['Products'] as List<dynamic>;
    
    // Convertir chaque élément de la liste en un objet Product
    List<Product> products = list.map((item) => Product.fromJson(item)).toList();

    return ProductList(products);
  }
}