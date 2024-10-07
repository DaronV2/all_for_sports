import 'dart:convert';
import 'package:all_for_sports/Widget/ProductItem.dart';
import 'package:all_for_sports/Services/Api.dart';
import 'package:all_for_sports/Services/ProductList.dart';

class FillProductList {

  static Future<List<ProductItem>> loadProductList() async {
    List<ProductItem> result = [];
    try {
      // Api.main();
      var resultGet = await Api.fetchApi('/products');
      ProductList productList = (ProductList.fromJson(jsonDecode(resultGet.body) as Map<String, dynamic>));
      return transformProductListToProductItem(productList);
    } on Exception catch (e) {
      print(e);
      result.add(const ProductItem(reference: "noFetchableApi", name: "noFetchableApi", quantity: 0, addingDate: "04/10/2024"));
      print("reel");
      return result;
    }
  }

  static List<ProductItem> transformProductListToProductItem(ProductList prodList){
    List<ProductItem> list =[];
    prodList.productList.forEach((prod){
      ProductItem item = ProductItem(reference: prod.productReference, name: prod.description, quantity: prod.quantity, addingDate: prod.addingDate,);
      list.add(item);
    });
    return list;
  }
}
