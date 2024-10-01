import 'dart:convert';

import 'package:all_for_sports/Services/Product.dart';
import 'package:http/http.dart' as http; // https://docs.flutter.dev/cookbook/networking/fetch-data

class FillProductList {

  static void main() async {
    final result = await http.get(Uri.parse('https://monapi.com/produits'));
    if (result.statusCode == 200){
      print(Product.fromJson(jsonDecode(result.body) as Map<String, dynamic>));
    }
    else{
      throw Exception('Failed');
    }
  }
//Faire api enft pcq impossible lire fichier
}
