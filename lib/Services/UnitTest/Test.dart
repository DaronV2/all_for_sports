import 'package:all_for_sports/Services/ConvertCode.dart';

void main() {
  String clientProductCode1 = ProductCodeTransformer.transform('Decathlon');
  String clientProductCode2 = ProductCodeTransformer.transform('Intersport');
  String clientProductCode3 = ProductCodeTransformer.transform('Nike');

  print(clientProductCode1); // Exemple : DECSPOA7D3J2K1L
  print(clientProductCode2); // Exemple : INTSPOH9K4M2Z7L
  print(clientProductCode3); // Exemple : NIKSPOE8F5G3X6P
}
