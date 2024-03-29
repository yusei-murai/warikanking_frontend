import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:warikanking_frontend/infras/secure_storage_infra.dart';
import 'package:http/http.dart' as http;
import 'package:warikanking_frontend/usecases/signin_usecase.dart';
import 'package:warikanking_frontend/views/accounts/signin_page.dart';

class FriendsApi{
  static Future<List?> getFriends(String userId, BuildContext context) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/users/$userId/friends/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json; charset=utf8','Authorization': 'JWT ${jwtToken['access']}'};

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
        List data = jsonDecode(response.body);
        return data;
      }
      throw Exception('Failed to load data');
    }catch(e){
      throw Exception(e);
    }
  }
}