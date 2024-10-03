import 'package:http/http.dart' as http;
import 'package:http/http.dart'; // https://docs.flutter.dev/cookbook/networking/fetch-data


class Api {

  static Future<Response> fetchApi(String apiPage) async {
    var url = Uri.http('127.0.0.1:30000', apiPage);
    return await http.get(url);
  }

}