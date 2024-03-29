import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:warikanking_frontend/infras/secure_storage_infra.dart';
import 'package:warikanking_frontend/usecases/signin_usecase.dart';
import 'package:warikanking_frontend/views/accounts/signin_page.dart';

class AccountsApi{
  static Future<dynamic> getToken(String email, String password) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/auth/jwt/create');
      Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8'};
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
      throw Exception(e);
    }
  }

  static Future<dynamic> refresh(String refreshToken) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/auth/jwt/refresh');
      Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8'};
      String body = json.encode({
        'refresh': refreshToken,
      });

      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        return null;
      }
    }catch(e){
      throw Exception(e);
    }
  }

  static Future<dynamic> createUser(String name, String userIdentifier, String email, String password) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/auth/users');
    Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8'};
    String body = json.encode({
      'name': name,
      'user_identifier': userIdentifier,
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
    var jwtToken = await SecureStorageInfra.readAllStorage();
    Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 401) {
      var ref = await SigninUsecase.refresh(jwtToken['refresh']);
      if (ref != true) {
        throw Exception('login');
      }
      jwtToken = await SecureStorageInfra.readAllStorage();
      headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};
      response = await http.get(url, headers: headers);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['user_id'];
    }
    throw Exception('Failed to load data');
  }

  static Future<Map<String, dynamic>?>? getUsersDictByEventId(String eventId, BuildContext context) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$eventId/users/');
    var jwtToken = await SecureStorageInfra.readAllStorage();
    Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 401) {
      var ref = await SigninUsecase.refresh(jwtToken['refresh']);
      if (ref != true) {
        if(context.mounted){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SigninPage()),
          );
        }
        throw Exception('login');
      }
      jwtToken = await SecureStorageInfra.readAllStorage();
      headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};
      response = await http.get(url, headers: headers);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    }
    throw Exception('Failed to load data');
  }
}