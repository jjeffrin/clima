import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Network {
  Future<Map<String, dynamic>> fetch(String authority, String unencodedPath,
      Map<String, dynamic>? queryParams) async {
    var url = Uri.https(authority, unencodedPath, queryParams);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Future.value(jsonResponse);
    } else {
      return Future.error(
          'Something went wrong while fetching API data. Status Code: ${response.statusCode}');
    }
  }
}
