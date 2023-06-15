import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warikanking_frontend/infras/secure_storage_infra.dart';

class AccountsApi{
  static Future<dynamic> getToken(String email, String password) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/auth/jwt/create');
      Map<String, String> headers = {'content-type': 'application/json; charset=utf8'};
      String body = json.encode({
        'email': email,
        'password': password,
      });

      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data; //refresh:リフレッシュトークン access:アクセストークン
      } else {
        return null;
      }
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> createUser(String name, String email, String password) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/auth/users');
    Map<String, String> headers = {'content-type': 'application/json; charset=utf8'};
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

  static Future<dynamic> getUsername(String userId) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/users/$userId/name/');
    Map<String, String> headers = {'content-type': 'application/json; charset=utf8'};

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['user_id'];
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?>? getUsersDictByEventId(String eventId) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$eventId/users/');
    Map<String, String> headers = {'content-type': 'application/json; charset=utf8'};

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }
}