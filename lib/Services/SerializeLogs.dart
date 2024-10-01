import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SerializeLogs {
  SerializeLogs(this.id, this.password); // Constructeur

  final String id;
  final String password;

  Map<String, dynamic> toJson() => {
    'identifiant' : id,     //Entrer "identifiant" : id , dans le json
    'password' : password, // Entrer "password" : password , dans le json
  };
}