import 'dart:convert';
import 'package:all_for_sports/Services/WareHouseProvider.dart';
import 'package:all_for_sports/Widget/ProductItem.dart';
import 'package:all_for_sports/Services/Api.dart';
import 'package:all_for_sports/Services/ProductList.dart';

class FillProductList {

  static String entrepot = WareHouseProvider.getEntrepot();

  // Fonction loadProductList : 
  //  paramètres : 
  //    - aucun
  //  Retourne List<ProductItem> qui contient les Produits présents dans l'api
  static Future<List<ProductItem>> loadProductList() async {
    List<ProductItem> result = [];
    try {
      var resultGet = await Api.fetchApi('/products'); // Requete HTTP sur api /products
      ProductList productList = (ProductList.fromJson(jsonDecode(resultGet.body) as Map<String, dynamic>)); // Deserialise l'objet JSON en objet Dart ProductList
      return transformProductListToProductItem(productList);
    } on Exception catch (e) {
      print(e); 
      result.add(const ProductItem(reference: "noFetchableApi", name: "noFetchableApi", quantity: 0, addingDate: "04/10/2024"));
      return result;
    }
  }

  // Fonction transformProductListToProductItem : 
  //  paramètres : 
  //    - ProductList prodList, contient une liste de produit
  //  Retourne List de ProdcutItem qui contient les données des produits de la ProductList
  static List<ProductItem> transformProductListToProductItem(ProductList prodList){
    List<ProductItem> list =[];
    prodList.productList.forEach((prod){
      if (prod.storage?.location == entrepot){
        ProductItem item = ProductItem(reference: prod.productReference, name: prod.description, quantity: prod.quantity, addingDate: prod.addingDate,);
        list.add(item);
      }
    });
    return list;
  }
}
