import 'dart:convert';

import 'package:http/http.dart' as http;

class AccountsApi{
  static Future<dynamic> getToken(String email, String password) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/apis/v1/auth/jwt/create');
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({
      'email': email,
      'password': password,
    });

    http.Response response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['access'];
    } else {
      return null;
    }
  }

  static Future<dynamic> createUser(String name, String email, String password) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/apis/v1/auth/users');
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({
      'name': name,
      'email': email,
      'password': password,
    });

    http.Response response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['email'];
    } else {
      return null;
    }
  }
}